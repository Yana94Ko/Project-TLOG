package com.tworaveler.tlog.home;

import java.util.List;

import com.tworaveler.tlog.log.LogVO;
import com.tworaveler.tlog.member.MemberVO;

public interface HomeService {
	// ����: �ֽ� �� ����Ʈ
	public List<LogVO> selectLikeLog();

	// ����: �ȷ��� �� ����Ʈ
	public List<LogVO> selectFollowLog(int userNum);

	// tNum�� �±� ����Ʈ
	public List<String> selectLogTag(int tNum);

	// tNum�� �۳��� ����Ʈ
	public List<LogVO> selectLogDetail(int tNum);

	// tNum�� �±׵� ���� ����Ʈ
	public List<LogVO> selectTagUsers(int tNum);

	// tNum�� �±� ����Ʈ
	public List<String> selectTagAll();

	// ����) �ȷο� ���� ����
	public List<MemberVO> FollowedUser();

	// userNum�� �±� ����Ʈ
	public List<String> selectmyTag(int userNum);
}