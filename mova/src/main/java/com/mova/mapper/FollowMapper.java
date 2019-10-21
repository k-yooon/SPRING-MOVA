package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.FollowVO;
import com.mova.domain.WishVO;

public interface FollowMapper {
	public int followInsert(FollowVO follow);					//팔로우하기
	public int followDelete(@Param("userid") String userid, @Param("follower") String follower);	//팔로우 취소하기
	public FollowVO read(@Param("userid") String userid, @Param("follower") String follower); 		//팔로우 했는지 체크
	public List<FollowVO> getFollowing(String userid);			//팔로잉 조회
	public List<FollowVO> getFollower(String userid);			//팔로워 조회
	public FollowVO followingCount(String userid);					//팔로잉 총 개수
	public FollowVO followerCount(String userid);					//팔로워 총 개수
}
