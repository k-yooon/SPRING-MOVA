console.log("Reply module .... reply.js");




var replyService = (function(){
	
	function add(content, callback, error){
		console.log("add reply........");
	$.ajax({
		type: 'post',
		url: '/replies/new',
		data: JSON.stringify(content),
		contentType: "application/json; charset=utf-8",
		success: function(result, status, xhr) {
			if (callback) {
				callback(result);
			}
		},
		error: function(xhr, status, er) {
			if (error) {
				error(er);
			}
		}
	})
	}
	
	function getList(param, callback, error){
		var qno = param.qno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + qno + "/" + page + ".json",
			function(data) {
			 if (callback) {
				 callback(data);
			 }
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	
	function remove(qreno, callback, error) {
		console.log("REMOVE");
		$.ajax({
			type: 'delete',
			url: '/replies/' + qreno,
			success: function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function update(content, callback, error) {
		console.log("qreno" + content.qreno);
		$.ajax({
			type: 'put',
			url : '/replies/' + content.qreno,
			data : JSON.stringify(content),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function get (qreno, callback, error) {
		$.get("/replies/" + qreno + ".json", function(result){
			if (callback) { callback(result);}
		}).fail(function(xhr, status, err){
			if (error) {
				error();
			}
		});
	}
	
	function displayTime(timeValue) {
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		if (gap < (1000 * 60 * 60 * 24)) {
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	;
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	
	};
})();
	
	//댓글 등록
	
/*	function add(reply, callback, error){
		console.log("reply.js - add()");
		$.ajax({
			type : 'post',
			url :'/replies/new',
			data : JSON.stringify(reply),
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
		})
	}//END add()
	
	//댓글 목록 가져오기
	function getList(param, callback, error){
		console.log("reply.js - getList()");
		var qno = param.qno;
		var page = param.page || 1;	//페이지 번호가 없을 때는 1로 처리

		$.getJSON("/replies/pages/" + qno + "/" + page + ".json",
			function(data){
				if(callback){ callback(data); }
				if(callback){ 
					//댓글 개수 + 목록
					callback(data.replyCnt, data.list);  
				}
			}
		).fail(
			function(xhr, status, er){
				if(error){ 	error(er); }
		    }
		);
	}//END getList()

	//댓글 삭제 
	function remove(qno, userid, callback, error){
		console.log("reply.js - remove()");
		$.ajax({
			type : 'delete',
			url :'/replies/' + qreno,
			data : JSON.stringify({ qreno:qreno, replyer:replyer }),
			contentType : "application/json; charset=UTF-8",
			success : function(result, status, xhr){
				if(callback){ callback(result);	}
			},
			error : function(xhr, status, er){
				if(error){ 	error(er);	}
			}
		})
	}//END remove()
	
	//댓글 수정
	function update(reply, callback, error){
		console.log("reply.js - update()");
		console.log("rno : " + reply.qreno);
		$.ajax({
			type : 'put',
			url :'/replies/' + reply.qreno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){ callback(result);	}
			},
			error : function(xhr, status, er){
				if(error){ 	error(er);	}
			}
		})
	}//END update()
	 
	//댓글 하나 가져오기
	function get(qreno, callback, error){
		console.log("reply.js - get()");
		$.get(
			"/replies/" + qreno + ".json",
			function(result){
				if(callback){ callback(result); }
			}
		).fail(
			function(xhr, status, er){
				if(error){ 	error(er); }
		    }
		);
	}//END get()
	
	return { get: get,
			 update: update,
			 add : add,
			 getList : getList, 
			 remove : remove };*/
 












