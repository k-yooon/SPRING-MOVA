package com.mova.service;

import java.awt.color.CMMException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mova.domain.CommJoaVO;
import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.FollowVO;
import com.mova.domain.MovieVO;
import com.mova.domain.ReportCommentVO;
import com.mova.domain.WishVO;
import com.mova.mapper.CommentMapper;
import com.mova.mapper.FollowMapper;
import com.mova.mapper.ReportCommentMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class CommentServiceImpl implements CommentService {
	private CommentMapper commentMapper;
	private FollowMapper followMapper;
	private ReportCommentMapper reportcommentMapper;

	@Override
	public List<CommentVO> getList(int mno, String keyword) {
		log.info("getList : " + mno + "keyword" + keyword);
		return commentMapper.getList(mno, keyword);
	}
	
	@Override
	public int getTotalComm(int mno) {
		return commentMapper.getTotalComm(mno);
	}

	@Override
	public int register(CommentVO comment) {
		log.info("register : " + comment);
		return commentMapper.insert(comment);
	}
	
	@Override
	public CommentVO getMyComm(int mno, String userid) {
		log.info("getMyComm : " + mno + userid);
		return commentMapper.getMyComm(mno, userid);
	}
	
	@Override
	public List<CommentVO> getMyAllComm(String userid, String keyword) {
		log.info("getMyAllComm : " +  userid);
		return commentMapper.getMyAllComm(userid, keyword);
	}
	
	@Override  //코멘트 삭제
	public int remove(int cno) {
		log.info("removeComm : " + cno);
		return commentMapper.delete(cno);
	}

	@Override	//코멘트 수정
	public int modify(CommentVO comment) {
		log.info("modifyComm : " + comment);
		return commentMapper.update(comment);
	}

	@Override
	public int report(int cno, String reporter) {
		log.info("report : " + cno);
		return commentMapper.reportInsert(cno, reporter);
	}

	@Override
	public List<ReportCommentVO> getReportList(Criteria cri) {
		log.info("getList with criteria : " + cri);
		return reportcommentMapper.getListWithPaging(cri);
	}

	@Override
	public int follow(FollowVO follow) {
		log.info("follow : " + follow);
		return followMapper.followInsert(follow);
	}
	
	@Override
	public FollowVO followCheck(String userid, String follower) {
		log.info("followCheck : " + userid + follower);
		return followMapper.read(userid, follower);
	}
	
	@Override
	public int followRemove(String userid, String follower) {
		log.info("followRemove : " + userid + follower);
		return followMapper.followDelete(userid, follower);
	}

	@Override
	public List<FollowVO> getFollowing(String userid) {
		log.info("getFollowing : " + userid);
		return followMapper.getFollowing(userid);
	}
	
	@Override
	public List<FollowVO> getFollower(String userid) {
		log.info("getFollower : " + userid);
		return followMapper.getFollower(userid);
	}
	
	@Override
	public FollowVO followingCount(String userid) {
		log.info("followingCount : " + userid);
		return followMapper.followingCount(userid);
	}

	@Override
	public FollowVO followerCount(String userid) {
		log.info("followerCount : " + userid);
		return followMapper.followerCount(userid);
	}

	
	@Override
	public List<MovieVO> getMyMovie(String userid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CommentVO> getStarCount(String userid) {
		return commentMapper.getStarCount(userid);
	}

	@Override
	public int getTotalCommById(String userid) {
		return commentMapper.getTotalCommById(userid);
	}
	
	@Override
	public int getReportCommTotal(Criteria cri) {
		log.info("get total count");	
		return reportcommentMapper.getTotalCount(cri);
	}

	@Override
	public double getStarAvgById(String userid) {
		return commentMapper.getStarAvgById(userid);
	}

	@Override
	public int getMuchStarById(String userid) {
		return commentMapper.getMuchStarById(userid);
	}

	@Override
	public int deleteInList(int rcno) {
		return reportcommentMapper.deleteInList(rcno);
	}
	
	@Transactional
	@Override
	public int addCommJoa(String userid, int cno) {
		commentMapper.updateJoaCnt(cno, +1);
		return commentMapper.addCommJoa(userid, cno);
	}

	@Override
	public List<CommJoaVO> chkCommJoa(String userid, int mno) {
		return commentMapper.chkCommJoa(userid, mno);
	}
	
	@Transactional
	@Override
	public int deleteCommjoa(String userid, int cno) {
		commentMapper.updateJoaCnt(cno, -1);
		return commentMapper.deleteCommjoa(userid, cno);
	}

}
