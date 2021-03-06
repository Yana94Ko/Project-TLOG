package com.tworaveler.tlog.member;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{
	@Inject
	MemberDAO dao;

	@Override
	public int insertMember(MemberVO vo) {
		return dao.insertMember(vo);
	}
	@Override
	public MemberVO selectMember(int userNum) {
		return dao.selectMember(userNum);
	}
	@Override
	public MemberVO selectMemberByKakao(String idKakao) {
		return dao.selectMemberByKakao(idKakao);
	}
	@Override
	public void updateMember(MemberVO vo) {
		dao.updateMember(vo);
	}
	@Override
	public int userDel(int userNum, int loginStatus) {
		return dao.userDel(userNum,loginStatus);
	}
	@Override
	public List<MemberVO> getAllHashtag() {
		return dao.getAllHashtag();
	}
	@Override
	public int mytagInsert(int tagNum, int userNum) {
		return dao.mytagInsert(tagNum, userNum);
	}
	@Override
	public int mytagDel(int userNum) {
		return dao.mytagDel(userNum);
	}
	@Override
	public List<MemberVO> getMytag(int userNum) {
		return dao.getMytag(userNum);
	}
	@Override
	public void setFollow(int userNum, int loginNum) {
		dao.setFollow(userNum, loginNum);
	}
	@Override
	public void unfollow(int userNum, int loginNum) {
		dao.unfollow(userNum, loginNum);
	}
	@Override
	public int isFollowed(int userNum, int loginUserNum) {
		return dao.isFollowed(userNum, loginUserNum);
	}
	@Override
	public List<MemberVO> setFollowerInfo(int userNum) {
		return dao.setFollowerInfo(userNum);
	}
	@Override
	public List<MemberVO> setFollowInfo(int userNum) {
		return dao.setFollowInfo(userNum);
	}
}
