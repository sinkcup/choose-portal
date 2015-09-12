<style type="text/css">
.module_group_open_categories_nav ul
{
}
.module_group_open_categories_nav ul.visiting
{
    display:inline;
}
.module_group_open_categories_nav ul a.visiting
{
    color:#489BF0;
}
.module_group_open_categories_nav ul li
{
    display:block;
    min-width:4em;
    float:left;
    margin:0 0 0 1em;
}
.module_group_open_categories_nav ul li a
{
    color:#000;
}
.module_group_open_categories_nav ul li a
{
    line-height:1.5em;
}
.module_group_open_categories_nav ul li a:hover
{
    color:#ff6600;
}
.module_group_open_categories_nav .group_title
{
    background:#7DA7F0;
    background:-moz-linear-gradient(top,#7DA7F0,#6993DC);
    background:-webkit-gradient(linear,left top,left bottom,color-stop(0.28,#7DA7F0),color-stop(0.72,#6993DC));
    border-radius:5px 5px 0 0;
    color:#fff;
    padding:2px 3px;
}
.module_group_open_categories_nav .sub_groups
{
    border:1px solid #DDD;
    border-radius:0 0 5px 5px;
    padding:3px 4px 10px 4px;
}
.module_group_open_categories_nav .sub_groups p.title
{
    font-size:1.1em;
    line-height:2em;
    padding:0 0 0 8px;
    color:#636E7A;
    font-weight:700;
}
.module_group_open_categories_nav .sub_groups .visiting p.title
{
    font-weight:bold;
    background:#fff url('http://img.shaixuan.org/bb1a2eae1faa91a6d79ab667f368d8ab.png') no-repeat left center;
}
</style>
<div class="module_group_open_categories_nav">
<?php
foreach($v['group'] as $group_name => $tmp)
{
	echo '<p class="group_title">' . $group_name . '</p>';
	echo '<div class="sub_groups">';
	foreach($tmp as $title => $categories)
	{
		echo '<p class="title">' . $title . '</p>';
		echo '<ul>';
		foreach($categories as $category_name=>$display)
		{
	
			$tmp = $v['uri_data'];
			$tmp['category_name'] = $category_name;
			echo '<li><a href="'.encodeFilterUri($tmp).'"';
			if($v['uri_data']['category_name']==$category_name)
			{
				echo 'class="visiting"';
			}
			echo '>'.$display.'</a></li>';
		}
		echo '</ul>';
                echo '<div class="clear"></div>';
	}
	echo '</div>';
}
?>
</div>
