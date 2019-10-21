console.log("follow module ... follow.js");

var followService = ( function(){

	//팔로우 처리
    function addFollow(follow, callback, error){
       $.ajax({
          type : 'post',
          url : '/member/followRegister',
          data : JSON.stringify(follow),      //데이터를 json화 시킴
          contentType : "application/json; charset=utf-8",
          success : function(result, status, xhr){
             if(callback){
                callback(result);
             }
          },error : function(xhr, status, er){
             if(error){
                error(er);
             }
          }
       })   
    }
 	 
 	//팔로우 체크
	function followCheck(param, callback, error){
	      var follower = param.follower;
	      var userid = param.userid;
	      console.log("followCheck" + follower + userid);
	      $.get('/member/follow/' + follower + '/' + userid + '.json', function(response){
	            if(callback){
	               callback(response);      
	            }
	         }).fail(function(xhr, status, err){
	            if(error){
	               error();
	            }
	         });
	 }
 	
 	//팔로우 삭제
	   function followRemove(follower, userid, callback, error){
	      $.ajax({
	         type : 'delete',
	         url : '/member/follow/' + follower + '/' + userid,
	         data: JSON.stringify({follower:follower, userid:userid}),
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
	 //팔로잉 목록
	  function getList(param, callback, error){
			var userid = param.userid;
			var no = param.no;
			console.log(userid + no);
			$.getJSON("/member/followList/" + userid + "/" + no + ".json", function(response){
					console.log(response);
					if(callback){
						callback(response);		
					}
				}).fail(function(xhr, status, err){
					if(error){
						error();
					}
				});
	  }  
	  
	  //팔로잉 총 개수
	  function followingCount(userid, callback, error){
	      console.log("followingCount" + userid);
	      $.get('/member/following/' + userid + '.json', function(response){
	            if(callback){
	               callback(response);      
	            }
	         }).fail(function(xhr, status, err){
	            if(error){
	               error();
	            }
	         });
	 }
	  
	  //팔로워 총 개수
	  function followerCount(userid, callback, error){
	      console.log("followerCount" + userid);
	      $.get('/member/follower/' + userid + '.json', function(response){
	            if(callback){
	               callback(response);      
	            }
	         }).fail(function(xhr, status, err){
	            if(error){
	               error();
	            }
	         });
	 }
	  
	
	return { addFollow : addFollow,
			 followCheck : followCheck,
			 followRemove : followRemove,
			 getList : getList,
			 followingCount : followingCount,
			 followerCount : followerCount
			};
})();//end commentService