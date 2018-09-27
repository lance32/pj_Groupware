package com.sp.mail;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service(value = "mail.service")
public class MailServiceImpl implements MailService {
	@Autowired
	private MongoOperations mongo;
	
	@Override
	public void insertMail(Mail dto) {
		try {
			Query query = new Query();
			query.with(new Sort(Sort.Direction.DESC, "index"));
			query.fields().include("index");		// index만 불러옴
			Mail lastMail = mongo.findOne(query, Mail.class);
			
			long index = 1;
			if (lastMail != null)
				index = lastMail.getIndex() + 1;
			
			dto.setIndex(index);
			dto.setSendTime(new Date());
			mongo.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Mail readMail(long index) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Mail> list(String memberNum) {
		List<Mail> list = null;
		try {
			Query query = new Query();
			query.fields().include("index");
			query.fields().include("sendMail");
			query.fields().include("sendName");
			query.fields().include("subject");
			query.fields().include("content");
			query.fields().include("sendTime");
			query.limit(10);
			query.addCriteria(Criteria.where("memberNum").is(memberNum)); //.andOperator(Criteria.where("").is("")));
			list = mongo.find(query, Mail.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateMail(Mail dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteMail(long index) {
		// TODO Auto-generated method stub

	}

}
