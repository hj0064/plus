package com.fa.plus.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fa.plus.domain.Lesson;

@Mapper
public interface LessonMapper {
	public List<Lesson> allLessonList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}
