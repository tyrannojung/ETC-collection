$(function() {
    $( ".Date" ).datepicker({
    });
});

// $(document).ready(function(){
//     $("p").hide();
//     // $("ul > li:first-child a").next().show();
//     $("ul li a").click(function(){
//       $(this).next().slideToggle(300);
//       // $(this).next().slideDown(300);
//       $("ul li a").not(this).next().slideUp(300);
//       return false;
//     });
//     $("ul li a").eq(0).trigger("click");
//   });

$(document).ready(function(){
    $('.list_hover2, .qna_hover').hover(function(){
        $('.qna_hover').css({
            height: '150px' 
        });
    }, function(){
        $('.qna_hover').css({
            height: '0px' 
        });
    });


    $(document).on('click', '.img_com_view', function(){
        $('.img_com_view').removeClass('img_com_view_ck');
        $(this).addClass('img_com_view_ck');
    });

    $(document).on('click', '.reg_option_icon', function(){
        $('.reg_option_icon').removeClass('opt_ck_border');
        $(this).addClass('opt_ck_border');
    });

    $(document).on('click', '.reg_opt_sub_cf > .close', function(){
        $('.reg_option_icon').removeClass('opt_ck_border');
    });


});