$(function(){$(".enlarged-photo").colorbox({rel:"gallery-group1",maxWidth:"85%"}),$("#deleteGalleryConfirm").popup({vertical:"top",pagecontainer:".container",transition:"all 0.3s"}),$(".gallery-remove").click(function(){return $("#deleteGalleryConfirm #removeBtn").attr("file",$(this).attr("file")),$("#deleteGalleryConfirm").popup("show"),!1}),$("#removeBtn").click(function(){return $.ajax({type:"post",dataType:"json",url:$(this).attr("href"),data:[{name:"file",value:$(this).attr("file")}],success:function(e){var t;t="warning",201===e.recode&&(t="warning"),202===e.recode&&(t="information"),203===e.recode&&(t="error"),200===e.recode&&(t="success"),noty({text:e.reason,type:t,layout:"topCenter",timeout:"3000"}),200===e.recode&&($("#deleteGalleryConfirm").popup("hide"),setTimeout(function(){window.location.reload()},1e3))}}),!1})});