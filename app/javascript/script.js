/* global $*/

// public/posts/new.html.erbのタブメニュー
$(document).on('turbolinks:load', function() {
  const savedTabId = localStorage.getItem('activeTabId') || '#tab1';
  $('.tab-contents .tab').hide();
  $(savedTabId).show();
  $('.tab-menu .active').removeClass('active');
  $('.tab-menu a[href="' + savedTabId + '"]').addClass('active');
  $('.tab-menu a').on('click', function(event) {
    event.preventDefault();
    $('.tab-contents .tab').hide();
    $('.tab-menu .active').removeClass('active');
    $(this).addClass('active');
    const targetTabId = $(this).attr('href');
    $(targetTabId).show();
    localStorage.setItem('activeTabId', targetTabId);
  });
});



// レイアウトテンプレート . 投稿ページ . swiperを用いた画像プレビュー
$(document).on('turbolinks:load', function() {
  let layoutSwiper = new Swiper('#layout-swiper-container', {
    loop: true,
    navigation: {
      nextEl: '#layout-swiper-container .swiper-button-next',
      prevEl: '#layout-swiper-container .swiper-button-prev',
    },
    pagination: {
      el: '#layout-swiper-container .swiper-pagination',
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
        layoutSwiper.appendSlide(slide);
        layoutSwiper.update();
      };
      fileReader.readAsDataURL(file);
    });
  }

  function handleFileSelection() {
    let files = this.files;
    $('.layout_create_file_field').hide();
    $('.layout_add_file_field').show();
    $('.layout_remove_image_button').show();
    addImagesToSwiper(files);
  }

  $('.layout_add_file_field').hide();
  $('.layout_remove_image_button').hide();
  $('.layout_hidden_file_field_create').on('change', handleFileSelection);
  $('.layout_hidden_file_field_add').on('change', function() {
    let files = this.files;
    addImagesToSwiper(files);
  });
  $('.layout_remove_image_button').on('click', function() {
    if (layoutSwiper.slides.length > 0) {
      layoutSwiper.removeSlide(layoutSwiper.activeIndex);
      layoutSwiper.update();
      if (layoutSwiper.slides.length === 0) {
        $('.layout_add_file_field').hide();
        $('.layout_remove_image_button').hide();
        $('.layout_create_file_field').show();
        $('.layout_hidden_file_field_create').off('change').on('change', handleFileSelection);
      }
    }
  });
});


// キャンプギア . 投稿ページ . 画像プレビュー
$(document).on('turbolinks:load', function() {
  bindGearImageEvents($(document));
  $('.links').on('cocoon:after-insert', function(e, insertedItem) {
    bindGearImageEvents(insertedItem);
  });

  function bindGearImageEvents(parent) {
    parent.find('.gear_image_edit_button').hide();
    parent.find('.gear_image_remove_button').hide();
    parent.find('.gear_hidden_file_field_create').on('change', function() {
      let files = this.files;
      if (files.length > 0) {
        let file = files[0];
        let reader = new FileReader();
        reader.onload = function(e) {
          let imgPreview = $('<img>')
            .attr('src', e.target.result)
            .addClass('preview_image')
            .attr('width', '156')
            .attr('height', '104');
          parent.find('.image_preview_field').html(imgPreview).show();
          parent.find('.gear_image_field').hide();
          parent.find('.gear_image_edit_button').show();
          parent.find('.gear_image_remove_button').show();
        };
        reader.readAsDataURL(file);
      }
    });
    parent.find('.gear_hidden_file_field_edit').on('change', function() {
      let files = this.files;
      if (files.length > 0) {
        let file = files[0];
        let reader = new FileReader();
        reader.onload = function(e) {
          let imgPreview = $('<img>')
            .attr('src', e.target.result)
            .addClass('preview_image')
            .attr('width', '156')
            .attr('height', '104');
          parent.find('.image_preview_field').html(imgPreview);
        };
        reader.readAsDataURL(file);
      }
    });
    parent.find('.gear_image_remove_button').on('click', function() {
      parent.find('.image_preview_field').hide().empty();
      parent.find('.gear_image_field').show();
      parent.find('.gear_image_edit_button').hide();
      parent.find('.gear_image_remove_button').hide();
      parent.find('.gear_hidden_file_field_create').val('');
      parent.find('.gear_hidden_file_field_edit').val('');
    });
  }
});



// レイアウトテンプレート . 投稿詳細ページ . swiperを用いた画像プレビュー
$(document).on('turbolinks:load', function() {
  let layoutSwiperShow = new Swiper('#layout-swiper-container-show', {
    loop: true,
    navigation: {
      nextEl: '#layout-swiper-container-show .swiper-button-next',
      prevEl: '#layout-swiper-container-show .swiper-button-prev',
    },
    pagination: {
      el: '#layout-swiper-container-show .swiper-pagination',
    }
  });
});



// キャンプ飯テンプレート . swiperを用いた画像プレビュー
$(document).on('turbolinks:load', function() {
  let mealSwiper = new Swiper('#meal-swiper-container', {
    loop: true,
    navigation: {
      nextEl: '#meal-swiper-container .swiper-button-next',
      prevEl: '#meal-swiper-container .swiper-button-prev',
    },
    pagination: {
      el: '#meal-swiper-container .swiper-pagination',
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
        mealSwiper.appendSlide(slide);
        mealSwiper.update();
      };
      fileReader.readAsDataURL(file);
    });
  }

  function handleFileSelection() {
    let files = this.files;
    $('.meal_create_file_field').hide();
    $('.meal_add_file_field').show();
    $('.meal_remove_image_button').show();
    addImagesToSwiper(files);
  }

  $('.meal_add_file_field').hide();
  $('.meal_remove_image_button').hide();
  $('.meal_hidden_file_field_create').on('change', handleFileSelection);
  $('.meal_hidden_file_field_add').on('change', function() {
    let files = this.files;
    addImagesToSwiper(files);
  });
  $('.meal_remove_image_button').on('click', function() {
    if (mealSwiper.slides.length > 0) {
      mealSwiper.removeSlide(mealSwiper.activeIndex);
      mealSwiper.update();
      if (mealSwiper.slides.length === 0) {
        $('.meal_add_file_field').hide();
        $('.meal_remove_image_button').hide();
        $('.meal_create_file_field').show();
        $('.meal_hidden_file_field_create').off('change').on('change', handleFileSelection);
      }
    }
  });
});


// キャンプ飯テンプレート . 投稿詳細ページ . swiperを用いた画像プレビュー
$(document).on('turbolinks:load', function() {
  let mealSwiperShow = new Swiper('#meal-swiper-container-show', {
    loop: true,
    navigation: {
      nextEl: '#meal-swiper-container-show .swiper-button-next',
      prevEl: '#meal-swiper-container-show .swiper-button-prev',
    },
    pagination: {
      el: '#meal-swiper-container-show .swiper-pagination',
    }
  });
});



// キャンプ場テンプレート . swiperを用いた画像プレビュー
$(document).on('turbolinks:load', function() {
  let siteSwiper = new Swiper('#site-swiper-container', {
    loop: true,
    navigation: {
      nextEl: '#site-swiper-container .swiper-button-next',
      prevEl: '#site-swiper-container .swiper-button-prev',
    },
    pagination: {
      el: '#site-swiper-container .swiper-pagination',
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
        siteSwiper.appendSlide(slide);
        siteSwiper.update();
      };
      fileReader.readAsDataURL(file);
    });
  }

  function handleFileSelection() {
    let files = this.files;
    $('.site_create_file_field').hide();
    $('.site_add_file_field').show();
    $('.site_remove_image_button').show();
    addImagesToSwiper(files);
  }

  $('.site_add_file_field').hide();
  $('.site_remove_image_button').hide();
  $('.site_hidden_file_field_create').on('change', handleFileSelection);
  $('.site_hidden_file_field_add').on('change', function() {
    let files = this.files;
    addImagesToSwiper(files);
  });
  $('.site_remove_image_button').on('click', function() {
    if (siteSwiper.slides.length > 0) {
      siteSwiper.removeSlide(siteSwiper.activeIndex);
      siteSwiper.update();
      if (siteSwiper.slides.length === 0) {
        $('.site_add_file_field').hide();
        $('.site_remove_image_button').hide();
        $('.site_create_file_field').show();
        $('.site_hidden_file_field_create').off('change').on('change', handleFileSelection);
      }
    }
  });
});



// cocoonにおいて2番目以降のフォームのみ削除ボタンを出現させる
$(document).on('turbolinks:load', function() {
  $('.gear_nested_fields').each(function(index) {
    if (index === 0) {
      $(this).find('.gear_remove_btn').hide();
    } else {
      $(this).find('.gear_remove_btn').show();
    }
  });
  $('.ingredient_nested_fields').each(function(index) {
    if (index === 0) {
      $(this).find('.ingredient_remove_btn').hide();
    } else {
      $(this).find('.ingredient_remove_btn').show();
    }
  });
});