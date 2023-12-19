package com.fa.plus.admin.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fa.plus.admin.domain.Answer;
import com.fa.plus.admin.domain.MemberManage;
import com.fa.plus.admin.domain.Qna;
import com.fa.plus.admin.service.PlusManageService;
import com.fa.plus.common.MyUtil;

@Controller
@RequestMapping("/admin/plusManage/*")
public class PlusManageController {

	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private PlusManageService service;
	
	@RequestMapping(value = "plusList")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "userId") String schType,
			@RequestParam(defaultValue = "") String kwd,
			HttpServletRequest req, Model model) throws Exception{
		
		String cp = req.getContextPath();

		int size = 10;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			kwd = URLDecoder.decode(kwd, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schType", schType);
		map.put("kwd", kwd);
		
		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		
		List<MemberManage> list = service.plusList(map);
		
		String query = "";
		String listUrl = cp + "/admin/plusManage/plusList";
		
		if(kwd.length() != 0) {
			query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
		}
		
		if(query.length() != 0) {
			listUrl += "?" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);
		
		return ".admin.plusManage.plusList";
	}
	
	@GetMapping("article")
	public String articleForm(@RequestParam String userId, @RequestParam String page, Model model) {
		
		List<Qna> list = service.findByQna(userId);
		
		if(list.isEmpty()) {
			return "redirect:/admin/plusManage/plusList?page=" + page;
		}
		
		String userName = "";
		for(Qna vo : list) {
			userName = vo.getUserName();
		}
		
		model.addAttribute("userId", userId);
		model.addAttribute("userName", userName);
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		return "admin/plusManage/article";
	}
	
	// 회원상세 정보 : AJAX-Text 응답
	@GetMapping("profile")
	public String detaileMember(@RequestParam String userId, Model model) throws Exception {
		MemberManage dto = service.findById(userId);
		MemberManage memberState = service.findByState(userId);
		List<MemberManage> listState = service.listMemberState(userId);
		
		model.addAttribute("dto", dto);
		model.addAttribute("memberState", memberState);
		model.addAttribute("listState", listState);

		return "admin/plusManage/profile";
	}
	
	@PostMapping("updateMemberState")
	@ResponseBody
	public Map<String, Object> updateMemberState(MemberManage dto) throws Exception {

		String state = "true";
		try {
			// 회원 활성/비활성 변경
			Map<String, Object> map = new HashMap<>();
			map.put("userId", dto.getUserId());
			if (dto.getStateCode() == 0) {
				map.put("enabled", 1);
			} else {
				map.put("enabled", 0);
			}
			service.updateMemberEnabled(map);

			// 회원 상태 변경 사항 저장
			service.insertMemberState(dto);

			if (dto.getStateCode() == 0) {
				// 회원 패스워드 실패횟수 초기화
				service.updateFailureCountReset(dto.getUserId());
			}
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@GetMapping("updateMembership")
	public String updateMembership(@RequestParam String userId, @RequestParam String page) throws Exception {
		try {
			MemberManage dto = service.findById(userId);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberIdx", dto.getMemberIdx());
			if(dto.getMemberIdx() == 51) {
				return "admin.plusManage.plusList";
			}
			service.updateMembership(map);
		} catch (Exception e) {
		}

		return "redirect:/admin/plusManage/plusList";
	}
	
	@GetMapping("graph")
	public String graph(Model model) throws Exception{
		return ".admin.plusManage.graph";
	}
	
	@GetMapping("answerChart")
	@ResponseBody
	public Map<String, Object> answerChart() throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();
		List<Answer> list = service.answerChart();
		
		model.put("list", list);
		return model;
	}
	
	@GetMapping("answerChart1")
	@ResponseBody
	public Map<String, Object> answerChart1() throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();
		List<Answer> list = service.answerChart1();
		
		model.put("list", list);
		return model;
	}
	
	@GetMapping("answerChart2")
	@ResponseBody
	public Map<String, Object> answerChart2() throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();
		List<Answer> list = service.answerChart2();
		
		model.put("list", list);
		return model;
	}
	
	@GetMapping("answerChart3")
	@ResponseBody
	public Map<String, Object> answerChart3() throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();
		List<Answer> list = service.answerChart3();
		
		model.put("list", list);
		return model;
	}
	
	@GetMapping("answerChart4")
	@ResponseBody
	public Map<String, Object> answerChart4() throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();
		List<Answer> list = service.answerChart4();
		
		model.put("list", list);
		return model;
	}
}
