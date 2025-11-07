package com.phone.dao;

import java.util.List;

import com.phone.model.Post;

/*
 * DB 와 직접적으로 상호작용하는 클래스
 * 게시글에 대한 CRUD 기능 구현
 * SQL 쿼리를 사용하여 데이터베이스와 통신
 * 
 * Service 계층에서 이 Dao 클래스를 호출하여 데이터 접근
 * jsp 에서 dao 에 직접 접근하지 않고 service 를 통해 접근
 */
public class PostDao {
	public List<Post> getAllPosts() {
		return null;	//나중에 List<Post>으로 변경
	}
	
	public Post getPostById(int postId) {
		return null;	//나중에 Post 객체로 변경
	}
	
	public boolean createPost(int postId, String userId, String title, String content, String timestamp, int clickCount) {
		//DB에 저장
		return false;	//성공 여부 반환
	}
	
	public void updatePost(int postId, String title, String content) {
		//DB에서 수정
	}
	
	public void deletePost(int postId) {
		//DB에서 삭제
	}
	
	public List<Post> getPostsByUserNickname(String nickname) {
		//특정 사용자의 게시글 조회
		return null;	//나중에 List<Post>으로 변경
	}
	
	public void incrementClickCount(int postId) {
		//조회수 증가
	}
	
	public List<Post> getPostsByTitle(String title) {
		//제목으로 게시글 조회
		return null;	//나중에 List<Post>으로 변경
	}
	
	
}
