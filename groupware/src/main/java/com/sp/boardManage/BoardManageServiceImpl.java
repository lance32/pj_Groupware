package com.sp.boardManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("boardManage.boardManageService")
public class BoardManageServiceImpl implements BoardManageService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int createBoardManage(BoardManage dto) {
		int result=0;
		try {
			int count = dao.selectOne("boardManage.tableCount", dto.getTableName());
			if(count==0) {
				dao.insertData("boardManage.insertBoardManage", dto);
				
				dao.updateData("boardManage.createBoardTable", dto.getTableName());
				dao.updateData("boardManage.createBoardFileTable", dto.getTableName());
				dao.updateData("boardManage.createBoardLikeTable", dto.getTableName());
				dao.updateData("boardManage.createBoardReplyTable", dto.getTableName());
				dao.updateData("boardManage.createBoardReplyLikeTable", dto.getTableName());
				
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount() {
		int result = 0;
		try {
			result = dao.selectOne("boardManage.dataCount");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<BoardManage> listBoardManage() {
		List<BoardManage> list=null;
		
		try{
			list=dao.selectList("boardManage.listBoardManage");
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public BoardManage readBoardManage(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardManage readBoardManage(String board) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateBoardManage(BoardManage dto, String pathname) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoardManage(int num, String pathname) {
		// TODO Auto-generated method stub
		return 0;
	}
}
