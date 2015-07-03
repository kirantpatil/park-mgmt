$(function() {
    
    //$('#svgload').load('assets/dt.svg');
    $('#svgload').load('assets/drawing_plain.svg');
    //$('#svgload').load('assets/symbols_new.svg');
         
    var source = new EventSource('/user_stream');

    source.addEventListener('results', function(e){
      console.log('Received a message:', e.data);
      var b = $.parseJSON(e.data).pdata;
      var addr = $.parseJSON(e.data).ccaddr;
      var ccua = ipaddr.parse(addr);
      var ccu = ccua.octets[3];
      var zcu = $.parseJSON(e.data).zcaddr;
	//alert($('park\\:b').attr('value'));
	//alert($('park\\:f').attr('value'));
	//alert($('park\\:ccu').attr('value'));
	//alert($('park\\:zcu1').attr('value'));
	//alert($('park\\:zcu2').attr('value'));
      svg_change(b,ccu,zcu);
    });
       

	function svg_change(b,ccu,zcu) {
               var a = b.split("");
	       var rect, color;
	       var i = 0, j = i+1;
               var len = b.length, filled = 0, vacant = 0;
	       //alert (a);
               for (; i <= len; i++, j++) {
                 rect = $('#slot'+ j + zcu + ccu);
                //color = rect.css('fill'); 
		//alert (a[i]);
                //console.log('color:', color);  // logicto
	        //	alert(rect.fill);        // to implement
		//if (color == "blue") {         // reserved //verify what is the best soln..
                //  alert ("Slot is reserved");
		//} else 
                if (a[i] == 1){ 
                  rect.css('fill','red');
                  filled += 1; 
		} else {
                  rect.css('fill','green');
		}
               }
          //      vacant = len - filled;
           //     $('#filled').text(filled);
            //    $('#vacant').text(vacant);
             //   $('#total').text(b.length);
         }


    source.addEventListener('finished', function(e){
      console.log('Close:', e.data);
      source.close();
    });


          $('#btnTest').click(function(e)
           {
           });    
     });
