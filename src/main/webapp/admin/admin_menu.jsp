<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">ADMIN</div>
    </a>

	<hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Addons
    </div>
    
    <li class="nav-item">
        <a class="nav-link" href="admin.jsp?workgroup=admin&work=member_manager">
            <i class="fas fa-fw fa-table"></i>
            <span>회원관리</span></a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="admin.jsp?workgroup=admin&work=product_manager">
            <i class="fas fa-fw fa-table"></i>
            <span>제품관리</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="admin.jsp?workgroup=admin&work=pay_manager">
            <i class="fas fa-fw fa-table"></i>
            <span>주문관리</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="admin.jsp?workgroup=admin&work=notice_manager">
            <i class="fas fa-fw fa-table"></i>
            <span>공지사항 관리</span></a>
    </li>
        <li class="nav-item">
        <a class="nav-link" href="admin.jsp?workgroup=admin&work=qna_manager">
            <i class="fas fa-fw fa-table"></i>
            <span>Q&amp;A 관리</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="admin.jsp?workgroup=admin&work=review_manager">
            <i class="fas fa-fw fa-table"></i>
            <span>리뷰관리</span></a>
    </li>
    
    

    <hr class="sidebar-divider d-none d-md-block">

    <li class="nav-item">
        <a class="nav-link" href="index.jsp"  style="text-align: center; ">
            <span style="font-size:large;">메인 Yum</span></a>
    </li>

    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
