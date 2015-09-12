<?php
require FdHelperLib::getViewFilePath('head');//由于head中的title是由数据生成的，所以要先查数据，后输出页面。
?>
<body>
<style type="text/css">
/*layout*/
.area_1
{
    width:1240px;
    margin:0 auto;
}
.area_3 .module_group_open_categories_nav
{
    width:11em;
    margin:0 1em 0 0;
    float:left;
}
.area_4
{
    padding:200px 0 0 0;
}
</style>
<div class="area_1">
    <div class="area_2">
    <?php
    require FdHelperLib::getViewFilePath('logo_and_search');
    ?>
    </div>
    <div class="area_3">
    <?php
    require FdHelperLib::getViewFilePath('all_groups');
    ?>
    </div>
        <div class="clear"></div>
    <div class="area_4">
    <?php
        require FdHelperLib::getViewFilePath('contact_us');
    ?>
    </div>
</div>
<?php
require FdHelperLib::getViewFilePath('footer');
?>
</body>
</html>
