<?php
require FdHelperLib::getViewFilePath('head');//由于head中的title是由数据生成的，所以要先查数据，后输出页面。
?>
<body>
<style type="text/css">
/*layout*/
.area_1
{
    width:970px;
    margin:0 auto;
}
.area_4
{
}
</style>
<div class="area_1">
    <div class="area_2">
    <?php
    require FdHelperLib::getViewFilePath('logo_and_search');
    ?>
    </div>
    <div class="area_4">
    <?php
    require FdHelperLib::getViewFilePath('module/show_product');
    require FdHelperLib::getViewFilePath('contact_us');
    ?>
    </div>
</div>
</body>
</html>
