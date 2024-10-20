/* global $*/

// public/posts/new.html.erbのタブメニュー
$(document).on('turbolinks:load', function() {
  $('.tab-contents .tab:not(#tab1)').hide();
  $('.tab-menu a').on('click', function(event) {
    event.preventDefault();
    $('.tab-contents .tab').hide();
    $('.tab-menu .active').removeClass('active');
    $(this).addClass('active');
    $($(this).attr('href')).show();
  });
});


// swiperを用いた画像プレビュー
$(function() {
  let swiper = new Swiper('.swiper', {
    loop: true,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
  });

  function addImagesToSwiper(files) {
    $.each(files, function(index, file) {
      let fileReader = new FileReader();
      fileReader.onload = function(event) {
        let loadedImageUri = event.target.result;
        let slide = $('<div>').addClass('swiper-slide');
        let imgPreview = $('<img>')
          .attr('src', loadedImageUri)
          .addClass('preview_image')
          .attr('width', '450')
          .attr('height', '300');
        slide.append(imgPreview);
        swiper.appendSlide(slide);
        swiper.update();
      };
      fileReader.readAsDataURL(file);
    });
  }

  function handleFileSelection() {
    let files = this.files;
    // 初期フィールドを隠し、追加フィールドを表示
    $('.initial_display_field').hide();
    $('.add_file_field_container').show();
    $('.remove_image_container').show();
    // Swiperに画像を追加
    addImagesToSwiper(files);
  }

  $('.add_file_field_container').hide();
  $('.remove_image_container').hide();
  $('.initial_hidden_field').on('change', handleFileSelection);
  $('.add_hidden_field').on('change', function() {
    let files = this.files;
    addImagesToSwiper(files);
  });
  $('.remove_image_container').on('click', function() {
    if (swiper.slides.length > 0) {
      swiper.removeSlide(swiper.activeIndex);
      swiper.update();
      if (swiper.slides.length === 0) {
        $('.add_file_field_container').hide();
        $('.remove_image_container').hide();
        $('.initial_display_field').show();
        $('.initial_hidden_field').off('change').on('change', handleFileSelection);
      }
    }
  });
});



// cocoonにおいて2番目以降のフォームのみ削除ボタンを出現させる
$(document).on('turbolinks:load', function() {
  $('.nested-fields').each(function(index) {
    if (index === 0) {
      $(this).find('.remove-btn').hide();
    } else {
      $(this).find('.remove-btn').show();
    }
  });
});