<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>চাকমা অনুবাদ</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        .textwatermark {
            color: #d0d0d0;
            font-size: 140pt;
            position: absolute;
            -webkit-transform: rotate(-45deg);
            -moz-transform: rotate(-45deg);
            width: auto;
            height: auto;
            margin: 0;
            z-index: -1;
            left:0%;
            top:0%;
            -webkit-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }


        @media screen and (min-width: 0px) and (max-width: 699px) {
            #desktopbackground { display: none; }
            #mobilebackground { display: block; }
        }

        @media screen and (min-width: 700px) {
            #desktopbackground { display: block; }
            #mobilebackground { display: none; }
        }

    </style>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">

        <!-- Brand/logo -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#example-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">চাকমা অনুবাদ তথ্য সংগ্রহ</a>
        </div>

        <!-- Collapsible Navbar -->
        <div class="collapse navbar-collapse" id="example-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Link 1 <span class="sr-only">(current)</span></a></li>
                <li><a href="#">Link 2</a></li>
                <li><a href="#">Link 3</a></li>
            </ul>
        </div>

    </div>
</nav>

<c:set value="border:1px solid #cecece;margin-top: 1%;border-radius: 5px;" var="styleCode"/>

<c:if test="${not empty success and success}">
    <div class="container" style="margin-top: 1%;">
        <div class="row mb-3">
            <div class="alert alert-success " role="alert">
                &check; আপনার অনুবাদটি সফলভাবে জমা হয়েছে!
            </div>
        </div>
    </div>
    <c:set value="border:1px solid #cecece;border-radius: 5px;" var="styleCode"/>
</c:if>

<c:if test="${not empty another and another}">
    <div class="container" style="margin-top: 1%;">
        <div class="row mb-3">
            <div class="alert alert-info" role="alert">
                &check; বাক্য পরিবর্তন করা হয়েছে
            </div>
        </div>
    </div>
    <c:set value="border:1px solid #cecece;border-radius: 5px;" var="styleCode"/>
</c:if>

<div class="container" style="margin-top: 1%;">
    <div class="row mb-3">
        <strong style="color: darkslategrey">মোট সম্পন্ন: <c:out value="${command.totalSubmission}"/></strong>
    </div>
</div>

<div class="container rounded" style="${styleCode}background:rgba(240, 255, 240, .5);">

    <h2 class="text-center">চাকমা অনুবাদ তথ্য সংগ্রহ</h2>
    <br><br>
    <form:form modelAttribute="command" method="post" action="/create">
        <form:hidden path="answer.id"/>
        <form:hidden path="answer.question.id"/>

        <div class="row mb-3">
            <label for="banglaSentence" class="col-sm-2 col-form-label">বাংলা:</label>
            <div class="col-sm-10">
                <form:input path="answer.question.description"
                            class="form-control"
                            id="banglaSentence"
                            readonly="true"/>
            </div>
        </div>
        <br>
        <div class="row mb-3">
            <label for="chakmaSentence" class="col-sm-2 col-form-label">চাকমা:</label>
            <div class="col-sm-10">
                <form:input path="answer.description"
                            class="form-control"
                            placeholder="এখানে চাকমা অনুবাদটি বাংলা অক্ষরে লিখুন ..."
                            id="chakmaSentence"
                            required="required"
                            oninvalid="this.setCustomValidity('অনুগ্রহ করে পূরণ করুন')"
                            oninput="this.setCustomValidity('')"/>
            </div>
        </div>
        <br>
        <button type="submit" class="btn btn-default btn-primary" name="save">জমা দিন</button>
        <a href="/new" class="btn btn-default btn-primary">অন্য বাক্য করুন</a>
    </form:form>
</div>



<div id="desktopbackground">
    <div class="textwatermark" style="left:40%;top:0%;">𑄇<br>𑄃<br>𑄢</div>
    <div class="textwatermark" style="left:10%;top:40%;">𑄚<br>𑄡</div>
    <div class="textwatermark" style="left:70%;top:0%;">𑄒<br>𑄎</div>
</div>

<div id="mobilebackground">
    <div class="textwatermark" style="left:40%;top:10%;font-size: 85pt;">𑄇<br>𑄃<br>𑄢</div>
    <div class="textwatermark" style="left:20%;top:70%;font-size: 85pt;">𑄚</div>
    <div class="textwatermark" style="left:70%;top:0%;font-size: 85pt;">𑄒</div>
</div>
</body>
</html>



