package com.tworaveler.tlog.log;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.tworaveler.tlog.member.MemberVO;

@Mapper
@Repository
public interface LogDAO {
	// tNum의 태그 리스트
	public List<LogVO> selectLogTag(int tNum);

	// tNum의 글내용 리스트
	public List<LogVO> selectLogDetail(int tNum);

	// tNum의 태그된 유저 리스트
	public List<LogVO> selectTagUsers(int tNum);

	// 태그 전체 리스트
	public List<LogVO> selectTagAll();

	// userNum의 태그 리스트
	public List<LogVO> selectMyTag(int userNum);

	/* =============== home ===================== */
	// 팔로워 많은 유저
	public List<MemberVO> FollowedUser();

	// 최신 글 리스트
	public List<LogVO> selectLikeLog();

	// 팔로잉 글 리스트
	public List<LogVO> selectFollowLog(int userNum);

	/* =============== logShare ===================== */
	// 무한스크롤 리스트(최신순)
	public List<LogVO> selectNewLogs(int limit, int tNum);

	// 무한스크롤 리스트(좋아요순)
	public List<LogVO> selectLikeLogs(int limitNum, long cursor);

	// 무한스크롤 검색 리스트(최신순) - 제목/작성자
	public List<LogVO> searchNewLogs(String searchKey, String string, int tNum, int limitNum);

	// 무한스크롤 검색 리스트(최신순) - 태그
	public List<LogVO> searchNewLogsTag(String string, int tNum, int limitNum);

	// 무한스크롤 검색 리스트(좋아요순) - 제목/작성자
	public List<LogVO> searchLikeLogs(String searchKey, String string, long cursor, int limitNum);

	// 무한스크롤 검색 리스트(좋아요순) - 태그
	public List<LogVO> searchLikeLogsTag(String string, long cursor, int limitNum);

	/* =============== 프로필 ===================== */
	public List<LogVO> selectMyLogs(int userNum, int isWriter, int startNum, int limitNum);
	public List<LogVO> selectTaggedLogs(int userNum, int isWriter, int startNum, int limitNum);
	public List<LogVO> selectLikedLogs(int userNum, int isWriter, int startNum, int limitNum);
	// 날짜 검색
	public List<LogVO> searchMyLogs(int userNum, int isWriter, String searchStart, String searchEnd, int startNum, int limitNum);
	public List<LogVO> searchTaggedLogs(int userNum, int isWriter, String searchStart, String searchEnd, int startNum, int limitNum);
	public List<LogVO> searchLikedLogs(int userNum, int isWriter, String searchStart, String searchEnd, int startNum, int limitNum);
	
	/* =============== 글쓰기 ===================== */
	// travelLog 등록
	public int logWriteOk(LogVO vo);

	// travelDetail 등록
	public int detailWriteOk(int tNum, Map<String, Object> map);

	// 방금 작성한 tNum 가져오기
	public int getTNum(int userNum);

	// 태그 등록
	public int insertTagList(LogVO vo);

	// 해당 닉네임의 유저 검색
	public List<LogVO> getUserListByNick(String userNick);

	// 태그한 유저 등록
	public int insertUserList(LogVO vo);
	
	/* ================  logView ==================== */
	public LogVO getOneLog(int tNum, int logUser);
	
	//태그된 유저인지 확인
	public int isTagged(int tNum, int logUser);
	
	// 좋아요 수
	public LogVO getLikeNum(int tNum);

	// 좋아요 누르기
	public int LikeUp(int userNum, int tNum);

	// 좋아요 취소
	public int LikeDown(int userNum, int tNum);
	
	//글 삭제
	public int logDel(int tNum);
	/*================== logEdit =====================*/
	public int logEdit(LogVO vo);
	public int tagDel(LogVO vo);
	public int tagUserDel(LogVO vo);
	public int detailDel(LogVO vo);
}