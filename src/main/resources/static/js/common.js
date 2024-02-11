$(document).ready(function() {
    summernote_start('.summernote', '<%= request.getContextPath() %>');
});

function summernote_start(content,contextPath){
    $(content).summernote({
        placeholder:'여기에 내용을 적으세요.',
        height:250,
        // 에디터 한글 설정
        lang: 'ko-KR',
        toolbar: [
            // 글자 크기 설정
            ['fontsize', ['fontsize']],
            // 글자 [굵게, 기울임, 밑줄, 취소 선, 지우기]
            ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
            // 글자색 설정
            ['color', ['color']],
            // 표 만들기
            ['table', ['table']],
            // 서식 [글머리 기호, 번호매기기, 문단정렬]
            ['para', ['ul', 'ol', 'paragraph']],
            // 줄간격 설정
            ['height', ['height']],
            // 이미지 첨부
            ['insert',['picture']]
        ],
        // 추가한 글꼴
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
        // 추가한 폰트사이즈
        fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72','96'],
        // focus는 작성 페이지 접속시 에디터에 커서를 위치하도록 하려면 설정해주세요.
        focus : true,
        // callbacks은 이미지 업로드 처리입니다.
        callbacks:{
            onImageUpload : function(files, editor, welEditable) {
                //alert("image insert!!");
                //file size check!
                for (var i = files.length - 1; i >= 0; i--) {
                    if(files[i].size > 1024*1024*5){
                        alert("이미지는 5MB 미만입니다.");
                        return;
                    }
                }

                //file sending
                for (var i = files.length - 1; i >= 0; i--) {
                    sendImg(files[i], this,contextPath+'/common/summernote/uploadImg.do');
                }
            },
            onMediaDelete : function(target) {
                //alert(target[0].src);
                var answer=confirm("정말 이미지를 삭제하시겠습니다.");
                if(answer){
                    deleteImg(target[0].src,contextPath+'/common/summernote/deleteImg.do');
                }
            }
        }
    });
}