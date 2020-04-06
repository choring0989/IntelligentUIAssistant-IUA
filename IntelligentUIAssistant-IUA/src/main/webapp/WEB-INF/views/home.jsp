<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<!-- Bootstrap core JavaScript -->
<script src="resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Plugin JavaScript -->
<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Contact Form JavaScript -->
<script src="resources/js/jqBootstrapValidation.js"></script>
<script src="resources/js/contact_me.js"></script>

<!-- Custom scripts for this template -->
<script src="resources/js/freelancer.min.js"></script>

<!-- Theme CSS -->
<link href="resources/css/freelancer.min.css" rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link href="https://unpkg.com/filepond/dist/filepond.css"
	rel="stylesheet">

<!-- include jQuery library -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>

<!-- include FilePond library -->
<script src="https://unpkg.com/filepond/dist/filepond.min.js"></script>

<!-- include FilePond plugins -->
<script
	src="https://unpkg.com/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.js"></script>

<!-- include FilePond jQuery adapter -->
<script src="https://unpkg.com/jquery-filepond/filepond.jquery.js"></script>

<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js"></script>

<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
<script
	src="https://www.gstatic.com/firebasejs/7.5.0/firebase-analytics.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/6.2.3/firebase-storage.js"></script>
<script
	src="https://unpkg.com/filepond-plugin-file-encode/dist/filepond-plugin-file-encode.js"></script>
<script src="https://unpkg.com/filepond/dist/filepond.js"></script>

<title>IUA 메인 화면</title>

</head>
<body id="page-top">
	<!-- Navigation -->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav">
		<div class="container">
			<div>
				<a class="navbar-brand js-scroll-trigger" href="#page-top">Intelligent
					UI Assistant - IUA</a>
				<h6 style="color: white">UI 컴포넌트 분리 작업을 도와드립니다!</h6>
			</div>
			<button
				class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-primary text-white rounded"
				type="button" data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fa fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						href="#portfolio">예시 이미지</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Masthead -->
	<header class="masthead bg-primary text-black text-center">
		<div class="container d-flex align-items-center flex-column">

			<div class="row col-12" style="text-align: center">
				<div class="col-6"
					style="border: thick double #2c3e50; border-radius: 0.2rem; background-color: #ffffff;">
					<!--<input type="file" class="my-pond" name="filepond" /> -->
					<!--<i class="fa fa-file" style="font-size:48px; color:#0f3675;"></i>-->
					<div class="row">
						<input type="file" id="fileupload" class="btn btn-l btn-outline-light">
						<button id="uploadClick" class='btn btn-l btn-outline-light'>파일
							업로드</button>
					</div>
					<img id='iimage' style="max-height: 250px; max-width: 400px"></img>
					<span id="progress"></span>
				</div>
				<div class="col-6"
					style="border: thick double #2c3e50; border-radius: 0.2rem; height: 310px; background-color: #ffffff; margin: auto;">
					<div class="row">
						<button id="result" class='btn btn-l btn-outline-light'>결과 다운로드</button>
					</div>
					<img id='output' style="max-height: 250px; max-width: 400px"></img>
					<span id="progress"></span>
				</div>
			</div>

			<script>
			var firebaseConfig = {
				apiKey : "AIzaSyDn2ZgGOSm74iiBPRWIH8Y4oZYzbzDjtnw",
				authDomain : "intelligentuiassistant-iua.firebaseapp.com",
				databaseURL : "https://intelligentuiassistant-iua.firebaseio.com",
				projectId : "intelligentuiassistant-iua",
				storageBucket : "intelligentuiassistant-iua.appspot.com",
				messagingSenderId : "913781734373",
				appId : "1:913781734373:web:15ea08e4d78b26122b8d0c",
				measurementId : "G-VYG4RZRNBY"
			};
			// Initialize Firebase
			firebase.initializeApp(firebaseConfig);
			firebase.analytics();
			console.log(firebase);

			// Create a root reference
			var storageRef = firebase.storage().ref();
			var filename, base64data;
			
			$('#fileupload').on('propertychange change',
				function() {
					var file = $("#fileupload")[0].files[0];
					filename = file.name;
					var reader = new FileReader();
					reader.onload = function(e) {
						// 변환이 끝나면 reader.result로 옵니다.
						base64data = reader.result;
						console.log(base64data);
						document.getElementById('iimage').src = base64data;
						// 여기서 구조가 중요합니다.
						// 구조는 「data: 파일 타입; base64, 데이터」입니다.
						var data = base64data.split(',')[1];
						/*
						storageRef.child('images/' + filename).putString(base64data,'data_url').then(
						function(snapshot) {
							console.log('Uploaded a file!');
						});
						*/
						//data가 이제 데이터 입니다.
						//사실 ajax로 넘길때는 큰 사이즈 설정해서 데이터를 넘기면 빠르게 되는데
						//예제이다보니 프로그래스바 구조를 나타내기 위해 문자 1개 단위로 보내겠습니다.
						var sendsize = 1024;
						var filelength = data.length;
						var pos = 0;
						var upload = function() {
							$.ajax({
								type : 'POST',
								dataType : 'json',
								data : {
									filename : filename,
									filelength : filelength,
									filepos : pos,
									data : data.substring(pos,pos+sendsize)
								},
								url : './upload',
								success : function(data) {
									console.log("성공")
									// 전체가 전송될 때까지
									if (pos < filelength) {
										// 재귀
										setTimeout(upload,1);
									}
									pos = pos + sendsize;
									if (pos > filelength) {
										pos = filelength;}
									$('#progress').text(pos+ ' / '+ filelength);
								},
								error : function(jqXHR,textStatus,errorThrown) {
								},
								complete : function(jqXHR,textStatus) {
								}
							});
						};
						setTimeout(upload, 1);
					}
					// base64로 넘깁니다.
					reader.readAsDataURL(file);
				});
			
			$('#uploadClick').on('click', function() {
				var rd = Math.floor(Math.random() * (120 - 1)) + 1;
				storageRef.child('images/'+rd+filename).putString(base64data,'data_url').then(
					function(snapshot) {
						console.log('Uploaded a file!');
						var alt = alert("업로드 완료!");
						document.getElementById('output').src = 'resources/img/train.PNG';
					});
			});
			
			$('#result').on('click', function() {
				location.href='https://firebasestorage.googleapis.com/v0/b/intelligentuiassistant-iua.appspot.com/o/output.zip?alt=media&token=c449112a-a9a0-449f-b0ac-06a6ec8db89f';
			});
			
			</script>

			<!-- Masthead Heading -->
			<h3 class="masthead-heading text-uppercase mb-0"
				style="font-size: 2.5rem; margin: auto; padding-top: 10px;">분리하려는
				이미지를 업로드 해 주세요!</h3>

			<!-- Icon Divider -->
			<div class="divider-custom divider-dark">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fa fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>

			<!-- Masthead Subheading -->
			<p class="masthead-subheading font-weight-light mb-0">Graphic
				Artist - Web Designer - Illustrator</p>

		</div>
	</header>

	<!-- Portfolio Section -->
	<section class="page-section portfolio" id="portfolio">
		<div class="container">

			<!-- Portfolio Section Heading -->
			<h2
				class="page-section-heading text-center text-uppercase text-secondary mb-0">예시
				이미지</h2>

			<!-- Icon Divider -->
			<div class="divider-custom">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fa fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>

			<!-- Portfolio Grid Items -->
			<div class="row">

				<!-- Portfolio Item 1 -->
				<div class="col-md-6 col-lg-4">
					<div class="portfolio-item mx-auto" data-toggle="modal"
						data-target="#portfolioModal1">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div
								class="portfolio-item-caption-content text-center text-white">
								<i class="fa fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="resources/img/portfolio/cabin.png"
							alt="">
					</div>
				</div>

				<!-- Portfolio Item 2 -->
				<div class="col-md-6 col-lg-4">
					<div class="portfolio-item mx-auto" data-toggle="modal"
						data-target="#portfolioModal2">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div
								class="portfolio-item-caption-content text-center text-white">
								<i class="fa fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="resources/img/portfolio/cake.png"
							alt="">
					</div>
				</div>

				<!-- Portfolio Item 3 -->
				<div class="col-md-6 col-lg-4">
					<div class="portfolio-item mx-auto" data-toggle="modal"
						data-target="#portfolioModal3">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div
								class="portfolio-item-caption-content text-center text-white">
								<i class="fa fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="resources/img/portfolio/circus.png"
							alt="">
					</div>
				</div>

				<!-- Portfolio Item 4 -->
				<div class="col-md-6 col-lg-4">
					<div class="portfolio-item mx-auto" data-toggle="modal"
						data-target="#portfolioModal4">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div
								class="portfolio-item-caption-content text-center text-white">
								<i class="fa fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="resources/img/portfolio/game.png"
							alt="">
					</div>
				</div>

				<!-- Portfolio Item 5 -->
				<div class="col-md-6 col-lg-4">
					<div class="portfolio-item mx-auto" data-toggle="modal"
						data-target="#portfolioModal5">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div
								class="portfolio-item-caption-content text-center text-white">
								<i class="fa fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="resources/img/portfolio/safe.png"
							alt="">
					</div>
				</div>

				<!-- Portfolio Item 6 -->
				<div class="col-md-6 col-lg-4">
					<div class="portfolio-item mx-auto" data-toggle="modal"
						data-target="#portfolioModal6">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div
								class="portfolio-item-caption-content text-center text-white">
								<i class="fa fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="resources/img/portfolio/submarine.png"
							alt="">
					</div>
				</div>

			</div>
			<!-- /.row -->

		</div>
	</section>

	<!-- Footer -->
	<footer class="footer text-center">
		<div class="container">
			<div class="row">

				<!-- Footer Location -->
				<div class="col-lg-4 mb-5 mb-lg-0">
					<h4 class="text-uppercase mb-4">Location</h4>
					<p class="lead mb-0">
						2215 John Daniel Drive <br>Clark, MO 65243
					</p>
				</div>

				<!-- Footer Social Icons -->
				<div class="col-lg-4 mb-5 mb-lg-0">
					<h4 class="text-uppercase mb-4">Around the Web</h4>
					<a class="btn btn-outline-light btn-social mx-1" href="#"> <i
						class="fa fa-fw fa-facebook-f"></i>
					</a> <a class="btn btn-outline-light btn-social mx-1" href="#"> <i
						class="fa fa-fw fa-twitter"></i>
					</a> <a class="btn btn-outline-light btn-social mx-1" href="#"> <i
						class="fa fa-fw fa-linkedin-in"></i>
					</a> <a class="btn btn-outline-light btn-social mx-1" href="#"> <i
						class="fa fa-fw fa-dribbble"></i>
					</a>
				</div>

				<!-- Footer About Text -->
				<div class="col-lg-4">
					<h4 class="text-uppercase mb-4">About Freelancer</h4>
					<p class="lead mb-0">
						Freelance is a free to use, MIT licensed Bootstrap theme created
						by <a href="http://startbootstrap.com">Start Bootstrap</a>.
					</p>
				</div>

			</div>
		</div>
	</footer>

	<!-- Copyright Section -->
	<section class="copyright py-4 text-center text-white">
		<div class="container">
			<small>Copyright &copy; Your Website 2019</small>
		</div>
	</section>

	<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
	<div class="scroll-to-top d-lg-none position-fixed ">
		<a class="js-scroll-trigger d-block text-center text-white rounded"
			href="#page-top"> <i class="fa fa-chevron-up"></i>
		</a>
	</div>

	<!-- Portfolio Modals -->

	<!-- Portfolio Modal 1 -->
	<div class="portfolio-modal modal fade" id="portfolioModal1"
		tabindex="-1" role="dialog" aria-labelledby="portfolioModal1Label"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i>
					</span>
				</button>
				<div class="modal-body text-center">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-8">
								<!-- Portfolio Modal - Title -->
								<h2
									class="portfolio-modal-title text-secondary text-uppercase mb-0">Log
									Cabin</h2>
								<!-- Icon Divider -->
								<div class="divider-custom">
									<div class="divider-custom-line"></div>
									<div class="divider-custom-icon">
										<i class="fa fa-star"></i>
									</div>
									<div class="divider-custom-line"></div>
								</div>
								<!-- Portfolio Modal - Image -->
								<img class="img-fluid rounded mb-5"
									src="resources/img/portfolio/cabin.png" alt="">
								<!-- Portfolio Modal - Text -->
								<p class="mb-5">Lorem ipsum dolor sit amet, consectetur
									adipisicing elit. Mollitia neque assumenda ipsam nihil,
									molestias magnam, recusandae quos quis inventore quisquam velit
									asperiores, vitae? Reprehenderit soluta, eos quod consequuntur
									itaque. Nam.</p>
								<button class="btn btn-primary" href="#" data-dismiss="modal">
									<i class="fa fa-times fa-fw"></i> Close Window
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Portfolio Modal 2 -->
	<div class="portfolio-modal modal fade" id="portfolioModal2"
		tabindex="-1" role="dialog" aria-labelledby="portfolioModal2Label"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i>
					</span>
				</button>
				<div class="modal-body text-center">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-8">
								<!-- Portfolio Modal - Title -->
								<h2
									class="portfolio-modal-title text-secondary text-uppercase mb-0">Tasty
									Cake</h2>
								<!-- Icon Divider -->
								<div class="divider-custom">
									<div class="divider-custom-line"></div>
									<div class="divider-custom-icon">
										<i class="fa fa-star"></i>
									</div>
									<div class="divider-custom-line"></div>
								</div>
								<!-- Portfolio Modal - Image -->
								<img class="img-fluid rounded mb-5"
									src="resources/img/portfolio/cake.png" alt="">
								<!-- Portfolio Modal - Text -->
								<p class="mb-5">Lorem ipsum dolor sit amet, consectetur
									adipisicing elit. Mollitia neque assumenda ipsam nihil,
									molestias magnam, recusandae quos quis inventore quisquam velit
									asperiores, vitae? Reprehenderit soluta, eos quod consequuntur
									itaque. Nam.</p>
								<button class="btn btn-primary" href="#" data-dismiss="modal">
									<i class="fa fa-times fa-fw"></i> Close Window
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Portfolio Modal 3 -->
	<div class="portfolio-modal modal fade" id="portfolioModal3"
		tabindex="-1" role="dialog" aria-labelledby="portfolioModal3Label"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i>
					</span>
				</button>
				<div class="modal-body text-center">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-8">
								<!-- Portfolio Modal - Title -->
								<h2
									class="portfolio-modal-title text-secondary text-uppercase mb-0">Circus
									Tent</h2>
								<!-- Icon Divider -->
								<div class="divider-custom">
									<div class="divider-custom-line"></div>
									<div class="divider-custom-icon">
										<i class="fa fa-star"></i>
									</div>
									<div class="divider-custom-line"></div>
								</div>
								<!-- Portfolio Modal - Image -->
								<img class="img-fluid rounded mb-5"
									src="resources/img/portfolio/circus.png" alt="">
								<!-- Portfolio Modal - Text -->
								<p class="mb-5">Lorem ipsum dolor sit amet, consectetur
									adipisicing elit. Mollitia neque assumenda ipsam nihil,
									molestias magnam, recusandae quos quis inventore quisquam velit
									asperiores, vitae? Reprehenderit soluta, eos quod consequuntur
									itaque. Nam.</p>
								<button class="btn btn-primary" href="#" data-dismiss="modal">
									<i class="fa fa-times fa-fw"></i> Close Window
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Portfolio Modal 4 -->
	<div class="portfolio-modal modal fade" id="portfolioModal4"
		tabindex="-1" role="dialog" aria-labelledby="portfolioModal4Label"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i>
					</span>
				</button>
				<div class="modal-body text-center">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-8">
								<!-- Portfolio Modal - Title -->
								<h2
									class="portfolio-modal-title text-secondary text-uppercase mb-0">Controller</h2>
								<!-- Icon Divider -->
								<div class="divider-custom">
									<div class="divider-custom-line"></div>
									<div class="divider-custom-icon">
										<i class="fa fa-star"></i>
									</div>
									<div class="divider-custom-line"></div>
								</div>
								<!-- Portfolio Modal - Image -->
								<img class="img-fluid rounded mb-5"
									src="resources/img/portfolio/game.png" alt="">
								<!-- Portfolio Modal - Text -->
								<p class="mb-5">Lorem ipsum dolor sit amet, consectetur
									adipisicing elit. Mollitia neque assumenda ipsam nihil,
									molestias magnam, recusandae quos quis inventore quisquam velit
									asperiores, vitae? Reprehenderit soluta, eos quod consequuntur
									itaque. Nam.</p>
								<button class="btn btn-primary" href="#" data-dismiss="modal">
									<i class="fa fa-times fa-fw"></i> Close Window
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Portfolio Modal 5 -->
	<div class="portfolio-modal modal fade" id="portfolioModal5"
		tabindex="-1" role="dialog" aria-labelledby="portfolioModal5Label"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i>
					</span>
				</button>
				<div class="modal-body text-center">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-8">
								<!-- Portfolio Modal - Title -->
								<h2
									class="portfolio-modal-title text-secondary text-uppercase mb-0">Locked
									Safe</h2>
								<!-- Icon Divider -->
								<div class="divider-custom">
									<div class="divider-custom-line"></div>
									<div class="divider-custom-icon">
										<i class="fa fa-star"></i>
									</div>
									<div class="divider-custom-line"></div>
								</div>
								<!-- Portfolio Modal - Image -->
								<img class="img-fluid rounded mb-5"
									src="resources/img/portfolio/safe.png" alt="">
								<!-- Portfolio Modal - Text -->
								<p class="mb-5">Lorem ipsum dolor sit amet, consectetur
									adipisicing elit. Mollitia neque assumenda ipsam nihil,
									molestias magnam, recusandae quos quis inventore quisquam velit
									asperiores, vitae? Reprehenderit soluta, eos quod consequuntur
									itaque. Nam.</p>
								<button class="btn btn-primary" href="#" data-dismiss="modal">
									<i class="fa fa-times fa-fw"></i> Close Window
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Portfolio Modal 6 -->
	<div class="portfolio-modal modal fade" id="portfolioModal6"
		tabindex="-1" role="dialog" aria-labelledby="portfolioModal6Label"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i>
					</span>
				</button>
				<div class="modal-body text-center">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-8">
								<!-- Portfolio Modal - Title -->
								<h2
									class="portfolio-modal-title text-secondary text-uppercase mb-0">Submarine</h2>
								<!-- Icon Divider -->
								<div class="divider-custom">
									<div class="divider-custom-line"></div>
									<div class="divider-custom-icon">
										<i class="fa fa-star"></i>
									</div>
									<div class="divider-custom-line"></div>
								</div>
								<!-- Portfolio Modal - Image -->
								<img class="img-fluid rounded mb-5"
									src="resources/img/portfolio/submarine.png" alt="">
								<!-- Portfolio Modal - Text -->
								<p class="mb-5">Lorem ipsum dolor sit amet, consectetur
									adipisicing elit. Mollitia neque assumenda ipsam nihil,
									molestias magnam, recusandae quos quis inventore quisquam velit
									asperiores, vitae? Reprehenderit soluta, eos quod consequuntur
									itaque. Nam.</p>
								<button class="btn btn-primary" href="#" data-dismiss="modal">
									<i class="fa fa-times fa-fw"></i> Close Window
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>