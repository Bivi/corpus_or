/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(window).resize(function() {
   $("#div1").addClass("sel")
   $("#div1").height(100)
   $("#div1").width($(window).width()/2)
   $("#div1").css("left",100)
   $("#div1").css("top",100)
   
   $("#div2").height(25)
   $("#div2").width(25)
   $("#div2").css("left",25)
   $("#div2").css("top",25)
   
   $("#div3").height(40)
   $("#div3").width(40)
   $("#div3").css("left",$("#div1").width()-5-$("#div3").width())
   $("#div3").css("bottom",$("#div1").height()-5)
 })
