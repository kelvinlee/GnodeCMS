$(function()	{
	$(".enlarged-photo").colorbox({
		rel:'gallery-group1',
		maxWidth: '85%'
	});
	//Delete Confirmation
	$('#deleteGalleryConfirm').popup({
		vertical: 'top',
		pagecontainer: '.container',
		transition: 'all 0.3s'
	});

	$('.gallery-remove').click(function()	{
		$('#deleteGalleryConfirm #removeBtn').attr("file",$(this).attr("file"));
		$('#deleteGalleryConfirm').popup('show');
		return false;
	});

	$("#removeBtn").click(function(){
		$.ajax({
	    type: "post",
	    dataType: "json",
	    url: $(this).attr("href"),
	    data: [{name:"file",value:$(this).attr("file")}],
	    success: function(msg) {
	    	var type;
	      type = "warning";
	      if (msg.recode === 201) {
	        type = "warning";
	      }
	      if (msg.recode === 202) {
	        type = "information";
	      }
	      if (msg.recode === 203) {
	        type = "error";
	      }
	      if (msg.recode === 200) {
	        type = "success";
	      }
	      noty({
	        text: msg.reason,
	        type: type,
	        layout: 'topCenter',
	        timeout: '3000'
	      });
	    	if (msg.recode === 200) {
	    		$('#deleteGalleryConfirm').popup('hide');
	    		setTimeout(function(){window.location.reload();},1000);
	    	}

    	}
    });
    return false;
	});

});