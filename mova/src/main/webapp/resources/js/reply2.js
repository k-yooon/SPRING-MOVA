console.log("Recommend Reply  reply2.js");

var replyService2 = (function() {

   // 댓글 등록
   function add(content, callback, error) {
      console.log("add content..........");
      $.ajax({
         type : 'post',
         url : '/rereplies/new',
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
      })
   }// END add()

   // 댓글 목록 가져오기
   function getList(param, callback, error) {
      console.log("reply.js = getList()");
      var reno = param.reno;
      var page = param.page || 1; // 페이지 번호가 없을 때는 1로 처리

      $.getJSON("/rereplies/pages/" + reno + "/" + page + ".json",
            function(data) {
               if (callback) {
                  callback(data.replyCnt, data.list);
               }
            }).fail(function(xhr, status, err) {
         if (error) {
            error();
         }
      });
   }// END getList()

   // 댓글 삭제
   function remove(rereno, userid, callback, error) {
      $.ajax({
         type : 'delete',
         url : '/rereplies/' + rereno,
         data : JSON.stringify({
            rereno : rereno,
            userid : userid
         }),
         contentType : "application/json; charset=UTF-8",
         success : function(deleteResult, status, xhr) {
            if (callback) {
               callback(deleteResult);
            }
         },
         error : function(xhr, status, er) {
            if (error) {
               error(er);
            }
         }
      }); // END remove()
   }

   // 댓글 수정
   function update(content, callback, error) {
      console.log("reno : " + content.rereno);
      $.ajax({
         type : 'put',
         url : '/rereplies/' + content.rereno,
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
   }// END update()

   // 댓글 하나 가져오기
   function get(rereno, callback, error) {
      console.log("reply.js - get()");
      $.get("/rereplies/" + rereno + ".json", function(result) {
         if (callback) {
            callback(result);
         }
      }).fail(function(xhr, status, err) {
         if (error) {
            error();
         }
      });
   }// END get()
   
   return { get: get,
       update: update,
       add : add,
       getList : getList, 
       remove : remove };

})();