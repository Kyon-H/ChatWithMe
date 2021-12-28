package com.main.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.main.entity.UserImage;

@Repository
public class UserImageDaoImplement implements UserImageDao {

	@Resource private SessionFactory sessionFactory;
	@Override
	public UserImage getUserImage(int id) {
		// TODO Auto-generated method stub
		String hql = "from UserImage where userId = ?";
	    Query query = sessionFactory.getCurrentSession().createQuery(hql);
	    query.setParameter(0, id);
		return (UserImage)query.uniqueResult();
	}

	@Override
	public boolean deleteUserImage(int userId) {
		// TODO Auto-generated method stub
		String hql = "delete UserImage where userId=?";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);  
	    query.setParameter(0, userId);
		return query.executeUpdate()>0;
	}

	@Override
	public void addUserImage(UserImage userImage) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().save(userImage);
	}

	@Override
	public boolean updateUserImage(UserImage userImage) {
		// TODO Auto-generated method stub
		String hql = "update UserImage set userImg=? where userId = ?";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);  
	    query.setParameter(0, userImage.getUserImg());
	    query.setParameter(1, userImage.getUserId());
		return query.executeUpdate()>0;
	}
	
	@Override
	public boolean updateUserImage(int userId, String userImg) {
		// TODO Auto-generated method stub
		String hql = "update UserImage set userImg=? where userId = ?";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);  
	    query.setParameter(0, userImg);
	    query.setParameter(1, userId);
		return query.executeUpdate()>0;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<UserImage> getAllUserImage() {
		// TODO Auto-generated method stub
		String hql = "from UserImage";  
        Query query = sessionFactory.getCurrentSession().createQuery(hql);  
        return query.list();
	}
	
}
