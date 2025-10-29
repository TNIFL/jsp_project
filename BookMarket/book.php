<!doctype html>
<html class="h-100" >   
  <title>도서 정보</title>
  <link href="./resources/css/bootstrap.min.css" rel="stylesheet">   
  <script type="text/javascript">
	function addToCart() {
		if (confirm("도서를 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit();
		} else {		
			document.addForm.reset();
		}
	}
</script>      
    <!-- Custom styles for this template -->
    </head>
  <body class="d-flex flex-column h-100">
  <?php 
    require "./model.php";    
    require "./menu.php";


    try{
      $id = $_GET["id"];  
      
      $book =  getBookById($id) ;
      if ($book ==null) 
        throw new Exception();    
  ?>


<br>
 <main>
 <div class="container py-5">
   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
     <div class="container-fluid py-5">
       <h1 class="display-5 fw-bold">도서 정보</h1>
       <p class="col-md-8 fs-4">BookInfo</p>
      </div>
   </div>   
   <div class="row align-items-md-stretch">      
      <div class = "col-md-5">
        <img src ="./resources/images/<?php echo $book['filename']; ?>" style ="width: 70%" >
      </div>
      <div class = "col-md-6">
          <h2><?php  echo $book["name"]; ?></h2>
          <p><?php  echo $book["description"]; ?> 
          <p><b>도서코드 : </b>  <span class="badge text-bg-danger"> <?php echo $id; ?></span>
          <p><b>저자</b> : <?php echo $book["author"]; ?>
          <p><b>출판일</b> : <?php echo $book["releaseDate"]; ?> 
          <p><b>분류</b> : <?php echo $book["category"]; ?> 
          <p><b>재고수</b> : <?php echo $book["unitsInStock"]; ?> 
		      <p><?php  echo $book["unitPrice"]; ?>원          
          <p><form name="addForm" action="./addCart.php?id=<?php echo $id;?>" method="post">
          <a href="#" class="btn btn-info" onclick="addToCart()"> 도서주문 &raquo;</a> 
				  <a href="./cart.php" class="btn btn-warning"> 장바구니 &raquo;</a>	
          <a href="./books.php" class="btn btn-secondary"> 도서목록 &raquo;</a>  
          <a href="./review.php" class="btn btn-secondary"> 리뷰작성 &raquo;</a>  
    </form>    
        </div>
      </div>    
    </div>

</main>
<?php   
}
catch(Exception $e){     
   require "./exceptionNoBookId.php";
}   
    require "./footer.php";
?>
</body>
</html>
