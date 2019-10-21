console.log("comment module ... comment.js");

var commentService = ( function(){
	//코멘트 목록 가져오기
	function getList(mno, keyword, callback, error){
		console.log("commgetList");
		$.getJSON("/member/commentList/" + mno + '/' + keyword + ".json", function(response){
				if(callback){
					callback(response);		
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	function add(comm, callback, error, callback2){
		console.log("comment.js - add()");
		$.ajax({
			type : 'post',
			url : '/member/commentRegister',
			data : JSON.stringify(comm),		//데이터를 json화 시킴
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				console.log(callback);
				if(callback){
					callback(result);
				}
			},error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});	
	}
	
	function getMyComm(param, callback, error){
	      var mno = param.mno;
	      var userid = param.userid;
	      console.log(mno + " : " + userid);
	      $.get('/member/myCommentList/' + mno + '/' + userid + '.json', function(response){
	            if(callback){
	               callback(response);      
	            }
	         }).fail(function(xhr, status, err){
	            if(error){
	               error();
	            }
	         });
	  }
	
	function remove(cno, callback, error){
	      $.ajax({
	         type : 'delete',
	         url : '/member/commentRemove/' + cno,
	         data: JSON.stringify({cno:cno}),
	         contentType: "application/json; charset=utf-8",
	         success : function(deleteResult, status, xhr){
	            if(callback){
	               callback(deleteResult);
	            }
	         },
	         error : function(xhr, status, er){
	            if(error){
	               error(er);
	            }
	         }
	      });
	   }
	
	function update(comment, callback, error){
		console.log("cno : " + comment.cno);
		console.log("star : " + comment.star);
		console.log("content : " + comment.content);
		$.ajax({
			type : 'put',
			url : '/member/commentModify/' + comment.cno,
			data : JSON.stringify(comment),	
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	//좋아요 추가
	function addJoa(cno, userid, callback, error){
		$.ajax({
			type : 'post',
			url : '/member/addJoa/' + cno + '/' + userid,
			data : JSON.stringify({cno:cno, userid:userid}),		
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				console.log(callback);
				if(callback){
					callback(result);
				}
			},error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});	
	}
	//좋아요 체크
	function chkCommJoa(mno, userid, callback, error){
		console.log("chkCommJoa : " + mno);
		$.getJSON('/member/chkJoa/' + mno + '/' + userid + '.json', function(response){
            if(callback){
               callback(response);      
            }
         }).fail(function(xhr, status, err){
            if(error){
               error();
            }
         });
	}
	//좋아요 삭제
	function removeJoa(cno, userid, callback, error){
	      $.ajax({
	         type : 'delete',
	         url : '/member/removeJoa/' + cno + '/' + userid,
	         data: JSON.stringify({cno:cno, userid:userid}),
	         contentType: "application/json; charset=utf-8",
	         success : function(deleteResult, status, xhr){
	            if(callback){
	               callback(deleteResult);
	            }
	         },
	         error : function(xhr, status, er){
	            if(error){
	               error(er);
	            }
	         }
	      });
	   }
	
	return { getList : getList,
			 add : add,
			 getMyComm : getMyComm,
			 remove : remove,
			 update : update,
			 addJoa : addJoa,
			 chkCommJoa : chkCommJoa,
			 removeJoa : removeJoa};
})();//end commentService