<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include/header.jsp" %>
<html>
<body>
<%@include file="../../include/nav.jsp" %>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-8 col-md-10" style="margin-top: 60px;">
			<div class="card-header text-uppercase font-weight-bold" style="line-height: 40px">Summernote</div>
			<div class="card-body">
		        <div class="d-flex justify-content-end mt-2">
		        	<textarea class="summernote"></textarea>   
	            </div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
			var fontSizes = [ '8', '9', '10', '11', '12', '14','16', '18', '20', '22', '24', '28', '30', '36', '50', '72','100' ];
			var fontNames = [ 'Arial', 'Arial Black','Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '바탕체' ];
			var toolbar = [[ 'fontname', [ 'fontname' ] ],
						   [ 'fontsize', [ 'fontsize' ] ],
						   [ 'style',    [ 'bold', 'italic', 'underline','strikethrough', 'clear' ] ],
						   [ 'color', [ 'forecolor', 'color' ] ],
						   [ 'table', [ 'table' ] ],
						   [ 'para', [ 'ul', 'ol', 'paragraph' ] ],
						   [ 'height', [ 'height' ] ],
						   [ 'view', [ 'codeview' ] ],
						   [ 'insert', [ 'picture', 'link', 'video' ] ] ];
			var setting = {
				height : 300,
				minHeight : null,
				maxHeight : null,
				focus : true,
				lang : 'ko-KR',
				toolbar : toolbar,
				fontSizes : fontSizes,
				fontNames : fontNames,
				callbacks : { //여기 부분이 이미지를 첨부하는 부분
					onImageUpload : function(files, editor,
							welEditable) {
						for (var i = files.length - 1; i >= 0; i--) {
							uploadSummernoteImageFile(files[i],
									this);
						}
					}
				}
			};
			$('.summernote').summernote(setting);
		});
</script>
<script>
	/**
	 * 이미지 파일 업로드
	 */
	function uploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/uploadProductImageFile",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				$(el).summernote('editor.insertImage', data.url);
			}
		});
	}
</script>
</body>
</html>