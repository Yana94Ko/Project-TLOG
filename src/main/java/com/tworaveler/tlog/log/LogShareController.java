package com.tworaveler.tlog.log;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.tworaveler.tlog.member.MemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LogShareController {
	@Inject
	LogService service;
	
	@GetMapping("/logShare/logList") 
	public ModelAndView logList(HttpSession session) { 
		ModelAndView mav  = new ModelAndView();
		mav.setViewName("/logShare/logList");
		return mav;
	} 
	@GetMapping("/logShare/logList/searchs") 
	public ModelAndView search(HttpSession session, String searchKey, String searchWord) { 
		ModelAndView mav  = new ModelAndView();
		mav.addObject("searchKey", searchKey);
		mav.addObject("searchWord", searchWord);
		mav.setViewName("/logShare/logList");
		return mav;
	}
	//전체 로그리스트
	@ResponseBody // Ajax
	@RequestMapping(value = "/logShare/logLists", method = RequestMethod.GET)
	public List<LogVO> logLists(@RequestParam("startNum") int startNum, int newOrLike) {
		int limitNum =7; //한 번에 나오는 글 수
		
		List<LogVO> logLists = new ArrayList<LogVO>();
		if(newOrLike==0) { //최신순
			logLists = service.selectNewLogs(startNum, limitNum);
		}else { //좋아요순
			logLists = service.selectLikeLogs(startNum, limitNum);
		}
		//vo마다 태그리스트 넣기
		for(LogVO lvo : logLists) {
			lvo.setTagList(service.selectLogTag(lvo.gettNum()));
		}
		return logLists;
	}
	//검색한 로그리스트
	@ResponseBody // Ajax
	@RequestMapping(value = "/logShare/searchLists", method = RequestMethod.GET)
	public List<LogVO> searchLists(@RequestParam(value = "startNum") int startNum, String searchKey, String searchWord, int newOrLike) {
		int limitNum = 7;
		List<LogVO> logLists = new ArrayList<LogVO>();
		
		if(newOrLike==0) { //최신순
			if(searchKey.equals("tag")) {//태그
				logLists = service.searchNewLogsTag("%" + searchWord + "%", startNum, limitNum);
			}else {//제목, 작성자
				logLists = service.searchNewLogs(searchKey, "%" + searchWord + "%", startNum, limitNum);
			}
		}else { //좋아요순
			if(searchKey.equals("tag")) {//태그
				logLists = service.searchLikeLogsTag("%" + searchWord + "%", startNum, limitNum);
			}else {//제목, 작성자
				logLists = service.searchLikeLogs(searchKey, "%" + searchWord + "%", startNum, limitNum);
			}
		}

		if(logLists.size()== 0){
			//비었을 경우 태그리시트 띄워주기 위한 함수
			List<LogVO> tagList = service.selectTagAll();
			return tagList;
		}
		
		//vo마다 tNum의 태그리스트 넣기
		for(LogVO lvo : logLists) {
			lvo.setTagList(service.selectLogTag(lvo.gettNum()));
		}

		return logLists;
	}

	/*======================= LogView ===========================================*/
	@GetMapping("/logShare/logView") 
	public ModelAndView logView(HttpSession session, HttpServletRequest request, int tNum) { 
		ModelAndView mav  = new ModelAndView();
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		int logUser;
		if(userInfo!=null) {
			logUser = userInfo.getUserNum(); //로그인 한 유저넘버
			mav.addObject("logStatus", "Y");
		}else {
			logUser = 0; //로그인 한 유저넘버
		}
		LogVO vo = service.getOneLog(tNum, logUser);		
		int isTagged = service.isTagged(tNum, logUser);
		if(vo.getIsPrivate()==1 && isTagged==0 && vo.getUserNum()!=logUser) {//비밀일기일 때 태그된 유저가 아니고 작성자도 아니라면
			System.out.println("나가라");
			mav.setViewName("redirect:/member/profile?userNum="+vo.getUserNum()); //작성자 프로필로 리다이렉트	
		}else {			
			vo.setTagList(service.selectLogTag(tNum)); //태그리스트 넣기
			vo.setTagUserList(service.selectTagUsers(tNum)); //태그된 유저리스트 넣기

			mav.addObject("vo", vo);
			mav.addObject("detailList", service.selectLogDetail(tNum));
			mav.setViewName("/logShare/logView");
		}
		return mav;
	} 
	/*~~~~~~~~~~~~~~~~~~~~~~~~~ 좋아요 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	@ResponseBody // Ajax
	@RequestMapping(value = "/logShare/likeUp", method = RequestMethod.POST)
	public LogVO likeUp(@RequestParam("tNum") int tNum, HttpSession session) {
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		int logNum = userInfo.getUserNum(); //logNum
		System.out.println(logNum+"+"+tNum);
		service.LikeUp(logNum, tNum);
		
		return service.getLikeNum(tNum);
	}
	//~~~~~~~~~~~~~~~~~~~~~~~~~ 좋아요 취소 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@ResponseBody // Ajax
	@RequestMapping(value = "/logShare/likeDown", method = RequestMethod.GET)
	public LogVO likeDown(@RequestParam("tNum") int tNum, HttpSession session) {
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		int logNum = userInfo.getUserNum(); //logNum
		System.out.println(logNum+"+"+tNum);
		service.LikeDown(logNum, tNum);

		return service.getLikeNum(tNum);
	}
	
	
}
