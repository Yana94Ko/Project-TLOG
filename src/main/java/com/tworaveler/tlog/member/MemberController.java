package com.tworaveler.tlog.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tworaveler.tlog.KakaoAPI;
import com.tworaveler.tlog.TlogApplication;
import com.tworaveler.tlog.log.LogService;
import com.tworaveler.tlog.log.LogVO;

@Controller
public class MemberController {
	@Inject
	LogService logService;
	@Inject
	MemberService memberService;
	@Inject
	KakaoAPI kakao;
	
	// 로그인 	
	@GetMapping("/member/login")
	public String loginForm() {
		System.out.println("로그인하러옴");
		return "member/login";
	}
	
	//카카오 로그인
	@GetMapping("/member/kakaoLogin")
	public String kakaologin(HttpServletResponse response, String code, HttpSession session, HttpServletResponse res, RedirectAttributes redirect, HttpServletRequest request) throws IOException { // 로그인 토큰 받아오기
		System.out.println("카카오로그인");
		JSONObject tokenJson = kakao.getToken(code);
		String accessToken = tokenJson.getString("access_token");
		String refreshToken = tokenJson.getString("refresh_token");
		// 카카오 로그인후 받아온 userInfo를 memberVO에 설정 후
		MemberVO kakaoVO = new MemberVO(kakao.getUserInfo(accessToken));
		// 해당 회원정보로 회원 선택해 로그인
		MemberVO userInfo = memberService.selectMemberByKakao(kakaoVO.getIdKakao());

		if (userInfo != null) {//해당하는 회원정보가 있다면
			// 블랙회원 로그인시
			if (userInfo.getStatus() == 9) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('정지된 회원입니다. 정지사유는 관리자에게 문의하세요.');location.href='/member/login';</script>");
				out.flush();
				return "redirect:login";
			}
			session.setAttribute("userInfo", userInfo);
			session.setAttribute("userNum", userInfo.getUserNum());
			session.setAttribute("accessToken", accessToken);
			session.setAttribute("refreshToken", refreshToken);
			session.setAttribute("kakao", "true");
			if (userInfo.getStatus() == 1) {
				return "redirect:/admin/main";
			} else {
				return "redirect:/";
			}
		} else {//해당하는 회원정보가 없다면 회원가입 진행
			memberService.insertMember(kakaoVO);
			userInfo = memberService.selectMemberByKakao(kakaoVO.getIdKakao());
			redirect.addFlashAttribute("kakaoVO", userInfo);
			session.setAttribute("userInfo", userInfo);
			session.setAttribute("userNum", userInfo.getUserNum());
			session.setAttribute("accessToken", accessToken);
			session.setAttribute("refreshToken", refreshToken);
			session.setAttribute("kakao", "true");
			return "redirect:welcomePage";
		}
	}
	//구글 로그인
	
	//회원가입 페이지
	@GetMapping("/member/welcomePage")
	public ModelAndView signup(HttpServletRequest request, RedirectAttributes redirect) {
		ModelAndView mav = new ModelAndView();
		//해시태그 정보 받아오기
		mav.addObject("allTagList", memberService.getAllHashtag());
		mav.setViewName("member/welcomePage");
		return mav;
	}
	//회원가입
	@PostMapping("/member/welcomePageOk")
	public String welcomePageOk(MemberVO vo, HttpServletRequest request,HttpSession session) {
		int userNum = (int) session.getAttribute("userNum");
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		if(vo.getProfileImg()=="/img/profile/default_profile.png") {
            vo.setProfileImg("/img/profile/default_profile.png");
            System.out.println(vo.getProfileImg());
        }else {
            TlogApplication.profileImgUpload(vo, request);
            System.out.println(vo.getProfileImg());
        }		//회원정보 수정
		memberService.updateMember(vo);
		//수정된 정보로session 값 수정
		session.setAttribute("userInfo", memberService.selectMemberByKakao(userInfo.getIdKakao()));
		//myTag생성
		if(vo.getTagListCl()!=null) {
			for(int i : vo.getTagListCl()) {
				int tagNum = i;
				memberService.mytagInsert(tagNum, userNum);
			}
		}
		//카카오 로그인의 경우 카카오 로그인 진행
		if(vo.getIdKakao() != null) {
			return "redirect:/";
		}
		return "redirect:login";
	}
	//로그아웃
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	//유저페이지
	@GetMapping("/member/profile")
	public ModelAndView myProfile(HttpSession session,int userNum) {
		ModelAndView mav = new ModelAndView();
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		//게시글 수 받아오기
		int limitNum =5; //한 번에 나오는 글 수
		int isWriter=0;
		int loginUserNum;
		
		if(userInfo!=null) {
			loginUserNum=userInfo.getUserNum();//로그인 한 userNum
		}else {
			loginUserNum=0;
		}
		if(userNum==loginUserNum) { //로그인 한 userNum(임시)와 현재 열람중인 프로필 num이 같다면
			isWriter = 1;
		}
		//로그인한 회원정보 전달
		mav.addObject("loginUser", userInfo);
		mav.addObject("loginUserNum", loginUserNum);
		//해당회원 닉네임, 프로필사진 받아오기
		mav.addObject("userProfile", memberService.selectMember(userNum));
		//해당회원 쓴 글 갯수 받아오기
		mav.addObject("myLogCount", logService.selectMyLogs(userNum, isWriter, 0, limitNum).size());
		//팔로우 여부 받아오기
		mav.addObject("isFollowed", memberService.isFollowed(userNum, loginUserNum));
		//팔로워 받아오기
		mav.addObject("followerCount", memberService.setFollowerInfo(userNum).size());
		mav.addObject("followerList", memberService.setFollowerInfo(userNum));
		//팔로우하는 사람 받아오기
		mav.addObject("followCount", memberService.setFollowInfo(userNum).size());
		mav.addObject("followList", memberService.setFollowInfo(userNum));

		mav.setViewName("member/profile");
		return mav;
	}
	//유저 프로필 페이지 LOG탭 ajax 로 데이터 넘겨주기
	@ResponseBody
	@RequestMapping(value = "/member/profileLogList", method = RequestMethod.GET)
	public List<LogVO> logLists(@RequestParam("startNum") int startNum, int status, int userNum, HttpSession session) {
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		int limitNum =5; //한 번에 나오는 글 수
		int isWriter=0;
		int loginUserNum;
		
		if(userInfo!=null) {
			loginUserNum=userInfo.getUserNum();//로그인 한 userNum(임시)
		}else {
			loginUserNum=0;
		}
		if(userNum==loginUserNum) { //로그인 한 userNum(임시)와 현재 열람중인 프로필 num이 같다면
			isWriter = 1;
		}
		List<LogVO> logLists = new ArrayList<LogVO>();
		
		//나의 여행일기
		if(status==0) {
			logLists = logService.selectMyLogs(userNum, isWriter, startNum, limitNum);
		//태그된 일기
		}else if(status==1){
			logLists = logService.selectTaggedLogs(userNum, isWriter, startNum, limitNum);		
		//좋아요 누른 일기
		}else if(status==2){
			logLists = logService.selectLikedLogs(userNum, isWriter, startNum, limitNum);
		}
		//vo마다 태그리스트 넣기
		for(LogVO lvo : logLists) {
			lvo.setTagList(logService.selectLogTag(lvo.gettNum()));
		}
		return logLists;
	}
	//검색한 userProfile
	@ResponseBody
	@RequestMapping(value = "/member/searchAtProfileLogList", method = RequestMethod.GET)
	public List<LogVO> searchLists(@RequestParam(value = "startNum") int startNum, int status, int userNum, String searchStart, String searchEnd, HttpSession session) {
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		int limitNum = 5;
		int isWriter=0;
		int loginUserNum;
		
		if(userInfo!=null) {
			loginUserNum=userInfo.getUserNum();//로그인 한 userNum(임시)
		}else {
			loginUserNum=0;
		}
		List<LogVO> logLists = new ArrayList<LogVO>();
		
		//나의 여행일기
		if(status==0) {
			logLists = logService.searchMyLogs(userNum, isWriter, searchStart, searchEnd, startNum, limitNum);
		//태그된 일기
		}else if(status==1){
			logLists = logService.searchTaggedLogs(userNum, isWriter, searchStart, searchEnd, startNum, limitNum);		
		//좋아요 누른 일기
		}else if(status==2){
			logLists = logService.searchLikedLogs(userNum, isWriter, searchStart, searchEnd, startNum, limitNum);
		}
		//vo마다 태그리스트 넣기
		for(LogVO lvo : logLists) {
			lvo.setTagList(logService.selectLogTag(lvo.gettNum()));
		}
		return logLists;
	}
	@GetMapping("/member/follow")
	public ModelAndView follow(HttpSession session,int userNum) {
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		ModelAndView mav = new ModelAndView();
		int loginNum = userInfo.getUserNum();//로그인한 유저 번호
		//팔로우 정보 생성
		memberService.setFollow(userNum, loginNum);
		mav.setViewName("redirect:/member/profile?userNum="+userNum);
		return mav;
	}
	@GetMapping("/member/unfollow")
	public ModelAndView unfollow(HttpSession session,int userNum) {
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		ModelAndView mav = new ModelAndView();
		int loginNum = userInfo.getUserNum();//로그인한 유저 번호
		//팔로우 정보 삭제
		memberService.unfollow(userNum, loginNum);
		mav.setViewName("redirect:/member/profile?userNum="+userNum);
		return mav;
	}
	@GetMapping("/member/userEdit")
	public ModelAndView userEdit(HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		mav.addObject("userInfo", userInfo);
		//해시태그 정보 받아오기
		mav.addObject("allTagList", memberService.getAllHashtag());
		mav.addObject("myTagList", memberService.getMytag(userInfo.getUserNum()));
		mav.setViewName("/member/userEdit");
		return mav;
	}
	@PostMapping("/member/userEditOk")
	public ModelAndView userEditOk(MemberVO vo, HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		System.out.println(vo.getProfileImg()+"변경 전 프로필사진");
		if(vo.getProfileImg()=="/img/profile/default_profile.png") {
			vo.setProfileImg("/img/profile/default_profile.png");
			System.out.println(vo.getProfileImg());
		}else {
			TlogApplication.profileImgUpload(vo, request);
			System.out.println(vo.getProfileImg());
		}
		
		//회원정보 수정
		memberService.updateMember(vo);
		//myTag 수정(삭제 후 생성)
		memberService.mytagDel(userInfo.getUserNum());
		if(vo.getTagListCl()!=null) {
			for(int i : vo.getTagListCl()) {
				int tagNum = i;
				memberService.mytagInsert(tagNum, userInfo.getUserNum());
			}
		}
		//수정된 정보로session 값 수정
		session.setAttribute("userInfo", memberService.selectMemberByKakao(userInfo.getIdKakao()));
		session.setAttribute("userNum", userInfo.getUserNum());
		mav.setViewName("redirect:/member/profile?userNum="+userInfo.getUserNum());
		return mav;
	}
	@GetMapping("/member/memberDel")
	public ModelAndView memberDel(int userNum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberVO loginuserInfo = (MemberVO) session.getAttribute("userInfo");
		memberService.userDel(userNum,loginuserInfo.getStatus());
		session.invalidate();
		mav.setViewName("redirect:/");
		return mav;
	}
}