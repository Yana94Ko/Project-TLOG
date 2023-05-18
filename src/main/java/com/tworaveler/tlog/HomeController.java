package com.tworaveler.tlog;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tworaveler.tlog.log.LogService;
import com.tworaveler.tlog.log.LogVO;
import com.tworaveler.tlog.member.MemberVO;

@Controller
public class HomeController {
	@Inject
	LogService service;
	
	@GetMapping("/") 
	public ModelAndView home(HttpSession session) { 
		ModelAndView mav  = new ModelAndView();
		List<LogVO> logList;
		MemberVO userInfo = (MemberVO) session.getAttribute("userInfo");
		//(1) tLog 10개
		if(userInfo!=null) {
			mav.addObject("userInfo", userInfo);
			//팔로잉 tLog
			logList = service.selectFollowLog(userInfo.getUserNum()); //임시(logId)
			//vo마다 tNum의 태그리스트 넣기
			for(LogVO vo : logList) {
				vo.setTagList(service.selectLogTag(vo.gettNum()));
			}
		}else {
			//좋아요순 tLog
			logList = service.selectLikeLog();
			for(LogVO vo : logList) {
				vo.setTagList(service.selectLogTag(vo.gettNum()));
			}
		}
		mav.addObject("logList", logList);
		int cntLogListPage = 0;
		//[Yana] 로드되는 게시글에 맞춰 페이징 항목 나타나도록 설정하기 위한 switch구문
		switch (logList.size()){
			case 1: case 2: case 3: cntLogListPage = 1; break;
			case 4: case 5: case 6: cntLogListPage = 2; break;
			case 7: case 8: case 9: case 10: cntLogListPage = 3; break;
			case 11: case 12: case 13: cntLogListPage = 4; break;
			case 14: case 15: case 16: cntLogListPage = 5; break;
			default:  break;
		}
		mav.addObject("cntLogListPage", cntLogListPage);
		
		//(2) 팔로워 많은 유저
		List<MemberVO> followedUser = service.FollowedUser();
		for(MemberVO vo : followedUser) {
			//System.out.println(vo.getUserNick());
			vo.setTagList(service.selectMyTag(vo.getUserNum()));
		}
		mav.addObject("followedUser", followedUser);
		
		//(3) 태그 리스트
		List<LogVO> tagList = service.selectTagAll();
		mav.addObject("tagList", tagList);
		mav.setViewName("/home");
		return mav;
	} 
	
	@ResponseBody // Ajax
	@RequestMapping(value = "/home/logDetail", method = RequestMethod.GET)
	public List<LogVO> logDetail(@RequestParam("tNum") int tNum) {
		List<LogVO> detailList = service.selectLogDetail(tNum);
		for(LogVO vo : detailList) {
			vo.setTagUserList(service.selectTagUsers(tNum));
		}
		return detailList;
	}
}