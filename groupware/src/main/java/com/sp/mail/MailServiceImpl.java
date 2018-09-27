package com.sp.mail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
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
			Mail lastMail = mongo.findOne(query, Mail.class);
			
			long index = 1;
			if (lastMail != null)
				index = lastMail.getIndex() + 1;
			
			dto.setIndex(index);
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
	public List<Mail> list() {
		// TODO Auto-generated method stub
		return null;
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
