package com.sp.boardManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("boardManage.boardManageService")
public class BoardManageServiceImpl implements BoardManageService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
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
		BoardManage dto = null;
		try {
			dto = dao.selectOne("boardManage.readBoardManage1", num);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public BoardManage readBoardManage(String board) {
		BoardManage dto=null;
		try {
			dto=dao.selectOne("boardManage.readBoardManage2", board);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateBoardManage(BoardManage dto, String pathname) {
		int result=0;

		try{
			if(dto.getCanFile() == 0) {
				List<BoardFile> listFile=dao.selectList("boardManage.listBoardFile1", dto.getTableName());
				for(BoardFile vo:listFile) {
					fileManager.doFileDelete(vo.getSaveFilename(), pathname);
				}
				
				dao.deleteData("boardManage.deleteBoardFile1", dto.getTableName());
			}
			
			if(dto.getCanLike() == 0) {
				dao.deleteData("boardManage.deleteBoardLike", dto.getTableName());
			}

			if(dto.getCanReply() == 0) {
				dao.deleteData("boardManage.deleteBoardReply", dto.getTableName());
			}
			
			if(dto.getCanAnswer() == 0) {
				List<BoardFile> listFile=dao.selectList("boardManage.listBoardFile2", dto.getTableName());
				for(BoardFile vo:listFile) {
					fileManager.doFileDelete(vo.getSaveFilename(), pathname);
				}
				
				dao.deleteData("boardManage.deleteBoardFile2", dto.getTableName());
				
				dao.deleteData("boardManage.deleteBoardAnswer", dto.getTableName());
			}
			
			result=dao.updateData("boardManage.updateBoardManage", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteBoardManage(int num, String pathname) {
		int result = 0;
		try {
			BoardManage dto = readBoardManage(num);
			result=dao.deleteData("boardManage.deleteBoardManage", num);
			
			if(dto != null) {
				List<BoardFile> listFile=dao.selectList("boardManage.listBoardFile1", dto.getTableName());
				for(BoardFile vo:listFile) {
					fileManager.doFileDelete(vo.getSaveFilename(), pathname);
				}
				
				dao.updateData("boardManage.dropBoardFileTable", dto.getTableName());
				dao.updateData("boardManage.dropBoardReplyTable", dto.getTableName());
				dao.updateData("boardManage.dropBoardLikeTable", dto.getTableName());
				dao.updateData("boardManage.dropBoardTable", dto.getTableName());
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
}
