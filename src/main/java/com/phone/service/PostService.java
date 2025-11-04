package com.phone.service;

import java.util.List;

import com.phone.dao.PostDao;
import com.phone.model.Post;

/*
 * Service 클래스는 Dao 를 이용한 데이터 접근 + 비즈니스 로직 구현부
 * Dao 클래스에 직접적으로 접근하지 않고, service 클래스를 통해서 접근
 * jsp 도 마찬가지로 Dao에 직접 접근하지 않고, service 클래스를 통해서 접근
 * 
 * 회원가입, 로그인, 사용자 정보 수정, 사용자 계정 삭제 등의 기능 구현
 */
public class PostService {
	private final PostDao postDao = new PostDao();
	//게시물 전체 조회
	public List<Post> getAllPosts() {
		return postDao.getAllPosts();
	}
	//게시물 아이디로 조회
	public Post getPostById(int postId) {
		return postDao.getPostById(postId);
	}
	//게시물 생성
	public void createPost(int postId, String userId, String title, String content, String timestamp, int clickCount) {
		postDao.createPost(postId, userId, title, content, timestamp, clickCount);
	}
	//게시물 조회
	public void updatePost(int postId, String title, String content) {
		postDao.updatePost(postId, title, content);
	}
	//게시물 삭제
	public void deletePost(int postId) {
		postDao.deletePost(postId);
	}
}
