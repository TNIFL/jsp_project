<!doctype html>
<html class="h-100" >   
<title>도서 목록</title>
<head>
    <link href="./resources/css/bootstrap.min.css" rel="stylesheet">    
    
     <!-- Custom styles for this template -->
  </head>
  <body class="d-flex flex-column h-100">   
  <?php 
    require "./model.php";    
    require "./menu.php";
  ?>
  <br>
 <main>
 <div class="container py-5">
   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
     <div class="container-fluid py-5">
       <h1 class="display-5 fw-bold">장바구니</h1>
       <p class="col-md-8 fs-4">CartList</p>
      </div>
   </div>
 
   
   <div class="row align-items-md-stretch text-center">
    <?php
       session_start();
       $cartId = session_id();          
    ?>   
      <div class="col-md-12">
        <div class="p-5">
            <table width="100%">
				      <tr>
					      <td align="left"><a href="./deleteCart.php?cartId=<?=$cartId?>" class="btn btn-danger">삭제하기</a></td>
					      <td align="right"><a href="./shippingInfo.php?cartId=<?=$cartId?>" class="btn btn-success">주문하기</a></td>
				      </tr>
			      </table>
		    </div>
		    <div>
			    <table class="table table-hover">
				<tr>
					<th>도서</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>				
        <?php		            
					  $sum = 0;
            $cartList = "";
            if(isset($_SESSION["cartlist"])) 
                $cartList = $_SESSION["cartlist"];

					  if ($cartList == null)
                  $count = 0;
            else $count = count($cartList);

					  for (  $i = 0;  $i < $count;   $i++, next($cartList) ) { // 도서리스트 하나씩 출력하기                       
                $id= key($cartList);
                $book = $cartList[$id];
						    $total = $book["unitPrice"] * $book["quantity"];
                $sum = $sum + $total;                                                              
				?>
				<tr>
					<td width="20%" ><?=$id ?> - <?=$book["name"]?></td>
					<td width="10%"><?=$book["unitPrice"] ?></td>
					<td width="10%"><?=$book["quantity"] ?></td>
					<td width="10%"><?=$total ?></td>
					<td width="10%"><a href="./removeCart.php?id=<?=$id ?>" class="badge text-bg-danger">삭제</a></td>
				</tr>
				<?php	
					}
        ?>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><?=$sum ?></th>
					<th></th>
				</tr>
			</table>       
      </div>    

      <div class="col-md-2">
        <a href="./books.php" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
      </div>
    </div>     
  </div>   
</div> 
</main>
<?php     
    require "./footer.php";
?>
</body>
</html>
