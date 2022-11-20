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
    <script src="https://code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>

    <style>
        .textwatermark {
            /*color: #d0d0d0;*/
            color: #E3E3E3;
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

            .container
        }

        @media screen and (min-width: 700px) {
            #desktopbackground { display: block; }
            #mobilebackground { display: none; }
        }

    </style>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid" style="background:rgba(240, 255, 240, .5);">

        <!-- Brand/logo -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#example-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><strong style="color: black">চাকমা অনুবাদ তথ্য সংগ্রহ</strong></a>
        </div>

        <!-- Collapsible Navbar -->
        <div class="collapse navbar-collapse" id="example-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">মূল পাতা<span class="sr-only">(current)</span></a></li>
                <li><a href="/create">অনুবাদ করুন</a></li>
            </ul>
        </div>

    </div>
</nav>

<c:set value="border:1px solid #cecece;margin-top: 1%;border-radius: 5px;" var="styleCode"/>


<div class="container rounded">
<%--  google translate ->  This is a part of  chakma to bangla or english automatic translation research project. Here, we are collecting  data for our project. We will be very glad if you could help us translating the sentences. To translate, please click here.  --%>
    এটি চাকমা থেকে বাংলা বা ইংরেজি স্বয়ংক্রিয় অনুবাদ গবেষণা প্রকল্পের একটি অংশ। এখানে, আমরা আমাদের প্রকল্পের জন্য ডেটা সংগ্রহ করছি। সকলের সহযোগীতা একান্ত কাম্য। <br/>অনুবাদ করতে, <a href="/create">এখানে ক্লিক করুন</a>।
</div>

<div class="container" style="margin-top: 1%;">
    <div class="row mb-3 text-center">
        <h3><strong style="color: darkslategrey;">মোট অনুবাদ সম্পন্ন </strong></h3>
        <h2><strong style="color: darkslategrey;"><div id="tsub"></div></strong></h2>
    </div>
</div>

<div id="desktopbackground">
    <div class="textwatermark" style="left:40%;top:0%;">𑄇<br>𑄃<br>𑄢</div>
    <div class="textwatermark" style="left:10%;top:40%;">𑄚<br>𑄡</div>
    <div class="textwatermark" style="left:70%;top:0%;">𑄒<br>𑄎</div>
</div>

<div id="mobilebackground">
    <div class="textwatermark" style="left:40%;top:10%;font-size: 85pt;">𑄇<br>𑄃<br>𑄢</div>
    <div class="textwatermark" style="left:20%;top:70%;font-size: 85pt;">𑄚</div>
    <div class="textwatermark" style="left:60%;top:0%;font-size: 85pt;">𑄒</div>
</div>

<div class="navbar navbar-fixed-bottom">
    <div class="text-center p-3">
        ©2020 Copyright & Contact: <a class="text-dark">chakma.data.collection@gmail.com</a>
    </div>
</div>

<script>
    $(document).ready(function() {
        function setTotalSubmission() {
            $.ajax({
                url : '/totalSubmissions',
                data : null,
                success : function(responseText) {
                    $('#tsub').text(responseText);
                },
                complete: function() {
                    setTimeout(setTotalSubmission, 10000);
                }
            });
        };

        setTotalSubmission();
    });
</script>

</body>
</html>



