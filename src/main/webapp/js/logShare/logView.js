

//좋아요~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function LikeUp(tNum){
   var param = {"tNum":tNum};
   $.ajax({
      url:'/logShare/likeUp',
      data:param,
      type:'POST',
      success:function(r){
    	  	var tag="<i class='fa-solid fa-thumbs-up' onclick='LikeDown("+r.tNum+")' style='color:rgba(122, 140, 226,100%);'></i> &emsp;"+r.likeNum;
    		$(".logLike").html(tag);
      }
   });
}
//좋아요 취소~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function LikeDown(tNum){
   var param = {"tNum":tNum};
   $.ajax({
      url:'/logShare/likeDown',
      data:param,
      type:'GET',
      success:function(r){
    	  var tag="<i class='fa-regular fa-thumbs-up' onclick='LikeUp("+r.tNum+")'  style='color:rgba(122, 140, 226,100%);'></i> &emsp;"+r.likeNum;
    	  $(".logLike").html(tag);
      }
   })
}

//글 삭제~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function logDel(tNum,writerNum){
    if(sessionStorage.getItem("userNum")!=null){
        if(confirm('글을 삭제하시겠습니까?')){
            if(sessionStorage.getItem("userNum")!= writerNum){
                var param2 = {"tNum" : tNum, "writerNum" : writerNum};
                console.log(param2);
                $.ajax({
                    url:'/logShare/logDel',
                    data: param2,
                    type:'GET',
                    success:function(userNum){
                        alert('글이 삭제되었습니다.');
                        location.href='/member/profile?userNum='+userNum;
                    }
                })
            }else{
                alert("회원님의 게시글이 아닙니다!");
            }
        }
    }else{
        alert("로그인 후 해당 기능을 이용하세요!");
    }
}
//글 수정~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function logEdit(tNum,writerNum){
    if(sessionStorage.getItem("userNum")!=null){
        if(confirm('글을 수정하시겠습니까?')){
            if(sessionStorage.getItem("userNum")!= writerNum){
                location.href='/logShare/logEdit?tNum='+tNum+"&writerNum="+writerNum;
            }else{
                alert("회원님의 게시글이 아닙니다!");
            }
        }
    }
}