package com.activity.common.model.centerObjcet;

import java.util.ArrayList;
import java.util.List;

/**
 * @author ChenXb
 *
 *         2017年9月5日
 */
public class SuperPage<T> {
	private List<T> list = new ArrayList<T>();
	private int currentPage;
	private int totalPages;

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	@Override
	public String toString() {
		return "SuperPage [list=" + list + ", currentPage=" + currentPage + ", totalPages=" + totalPages + "]";
	}

	public SuperPage(List<T> list, int currentPage, int totalPages) {
		super();
		this.list = list;
		this.currentPage = currentPage;
		this.totalPages = totalPages;
	}

	public SuperPage() {
		super();
	}
}
