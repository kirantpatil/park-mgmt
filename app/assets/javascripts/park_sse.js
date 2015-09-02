    var source = new EventSource('/park_stream');

    source.addEventListener('results', function(e){
      console.log('Received a message:', e.data);
      if ( $.parseJSON(e.data).lstatus ) {
      var b = $.parseJSON(e.data).lstatus;
      var zcu = $.parseJSON(e.data).zcid;
      var floor = $.parseJSON(e.data).fid;
      var building = $.parseJSON(e.data).bid;
      var offset = $.parseJSON(e.data).offset;  

      var object = document.getElementById("" + building + floor);
          var svgdoc = object.contentDocument;
          svg_change(b,zcu,floor,building,offset,svgdoc);

      } else if ($.parseJSON(e.data).total){

      var vacant  = $.parseJSON(e.data).vacant;
      var occupied = $.parseJSON(e.data).occupied;
      var reserved = $.parseJSON(e.data).reserved;
      var total   = $.parseJSON(e.data).total;
      var floor = $.parseJSON(e.data).fid;
      var building = $.parseJSON(e.data).bid;
                $('#vacant'+floor+building).text(vacant);
                $('#occupied'+floor+building).text(occupied);
                $('#reserved'+floor+building).text(reserved);
                $('#total'+floor+building).text(total);

      } else if ($.parseJSON(e.data).total_b){

      var vacant  = $.parseJSON(e.data).vacant_b;
      var occupied = $.parseJSON(e.data).occupied_b;
      var reserved = $.parseJSON(e.data).reserved_b;
      var total   = $.parseJSON(e.data).total_b;
      var building = $.parseJSON(e.data).bid;
                $('#vacant'+building).text(vacant);
                $('#occupied'+building).text(occupied);
                $('#reserved'+building).text(reserved);
                $('#total'+building).text(total);
      }

    });
       

	function svg_change(b,zcu,fl,bu,offset,svgdoc) {

               var a = b.split("");
	       var i = 0,  j = offset+1;
               var len = b.length;
               var rect;

               for (; i < len; i++, j++) {
                 lot = "slot-"+bu+"-"+fl+"-"+zcu+"-"+j;
                 rect = svgdoc.getElementById("slot-"+j);
                 if ( rect == null) {
                   rect = svgdoc.getElementById(lot);
                 }
                 rect.setAttribute("id", lot);
                if (a[i] == "o"){ 
                  rect.style.setProperty("fill", "red");
		} else if(a[i] == "v")  {
                  function callback() {
                    if (this.style.getPropertyValue("fill") == "red")
                      return false;
                    this.style.setProperty("fill", "orange");
                    $.ajax({
                      url: "/floor/reserve?lot="+this.id+"&status="+"r",
                      type: "post",
                      // data: values,
                      success: function(){
                      },
                      error: function(){
                        alert('Retry once again');
                      }
                    });
                    this.removeEventListener("mouseover", callback1, false); 
                    this.removeEventListener("mouseout", callback2, false); 
                  }

                  function callback1() {
                    this.style.setProperty("opacity", "1");
                  }

                  function callback2() {
                    this.style.setProperty("opacity", "0.5");
                  }
  
                  rect.style.setProperty("fill", "green");
               
                  $(rect).off().one('click', callback);

                  rect.addEventListener("mouseover", callback1, false); 
                  rect.addEventListener("mouseout", callback2, false); 

		} else if(a[i] == "r")  {

                  function callback() {
                    this.style.setProperty("fill", "green");
                    $.ajax({
                      url: "/floor/reserve?lot="+this.id+"&status="+"v",
                      type: "post",
                      // data: values,
                      success: function(){
                      },
                      error: function(){
                        alert('Retry once again');
                      }
                    });
                    this.removeEventListener("mouseover", callback1, false); 
                    this.removeEventListener("mouseout", callback2, false); 
                  }

                  function callback1() {
                    this.style.setProperty("opacity", "1");
                  }

                  function callback2() {
                    this.style.setProperty("opacity", "0.5");
                  }
                  
                  rect.style.setProperty("fill", "orange");

                  $(rect).off().one('click', callback);

                  rect.addEventListener("mouseover", callback1, false); 
                  rect.addEventListener("mouseout", callback2, false); 
               }
             }
        }

    source.addEventListener('finished', function(e){
      console.log('Close:', e.data);
      source.close();
    });

var gonfix;
gonfix = function(){
    eval($("#gonvariables > script").html());
};

$(document).on('page:restore', gonfix);

var ready = function() {
  
           if ( typeof gon.bnumber != "undefined") {
           var bcount = gon.bnumber;
           var bstatus = gon.bstatus;

           for(var i = 0; i < bcount; i++) {
              $('#vacant'+bstatus[i].bid).text(bstatus[i].vacant_b);
              $('#occupied'+bstatus[i].bid).text(bstatus[i].occupied_b);
              $('#reserved'+bstatus[i].bid).text(bstatus[i].reserved_b);
              $('#total'+bstatus[i].bid).text(bstatus[i].total_b);
            }
          }

           if ( typeof gon.fstatus != "undefined") {
             var fstatus = gon.fstatus;
              $('#vacant'+fstatus.fid+fstatus.bid).text(fstatus.vacant);
              $('#occupied'+fstatus.fid+fstatus.bid).text(fstatus.occupied);
              $('#reserved'+fstatus.fid+fstatus.bid).text(fstatus.reserved);
              $('#total'+fstatus.fid+fstatus.bid).text(fstatus.total);
           }
           
      if ( typeof gon.lstatus != "undefined") {
        var l_status = gon.lstatus;
        for (var i = 0; i < l_status.length; i++) {
          var b = l_status[i].lstatus;
          var zcu = l_status[i].zcid;
          var floor = l_status[i].fid;
          var building = l_status[i].bid;
          var offset = l_status[i].offset;
  
          var object = document.getElementById("" + building + floor);
          object.addEventListener("load",function() {
          var svgdoc = object.contentDocument;
          svg_change(b,zcu,floor,building,offset,svgdoc);
         }, false);
       }
     }

  $("#threshold_id").change(function() {
    var value = $('select#threshold_id :selected').val();
                    $.ajax({
                      url: "/floor/threshold?value="+value,
                      type: "post",
                      // data: values,
                      success: function(){
                      },
                      error: function(){
                        alert('Retry once again');
                      }
                    });
    return false;
  });
};


$(document).ready(ready);
$(document).on('page:load', ready);
