$(document).ready(function(){
			
				$('.posts_list').bxSlider({
					minSlides: 1,
					maxSlides: 3,
					moveSlides: 1,
					slideWidth:370,
					slideMargin : 30,
					pager:false,
					nextSelector: '.recent_posts .controls .next',
					prevSelector :'.recent_posts .controls .prev' 
				});
				
				$(".toggle").click(function(){
					$(".main-menu").slideToggle();
				}); 
				
				$(window).resize(function(){
					if($(window).width() > 768){
						//참이면 할일
						$(".main-menu").show();
					} else{
						//거짓이면 할일
						$(".main-menu").hide();
					}
				});				
				//상단 메뉴고정
           var $header = $('header');
	       var $services = $('.services');
           $(window).scroll(function(){
                var $currentSct = $(this).scrollTop();	            
                var $offset = 400;
	            if($currentSct > 0){
		             $header.addClass('sticky'); 
	            }else{
		             $header.removeClass('sticky');
               	}
                //서비스 아이탬 나타나기
                var $serviceThreshold = $services.offset().top - $offset;
                var $serviceExecuted = false;
                if(!$serviceExecuted){
                    if($currentSct > $serviceThreshold){
		                 $services.addClass('active');
                         $serviceExecuted = true;  
	                }
                }
           }); 
	             	
});


           
           





