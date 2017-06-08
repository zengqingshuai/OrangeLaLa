/*
SQLyog Ultimate v12.4.1 (64 bit)
MySQL - 5.7.17 : Database - orange
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`orange` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `orange`;

/*Table structure for table `oll_activity` */

DROP TABLE IF EXISTS `oll_activity`;

CREATE TABLE `oll_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picsname` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `oll_activity` */

insert  into `oll_activity`(`id`,`picsname`,`status`,`path`) values 
(10,'0db6ad73-a9a5-4f9d-a584-f810303e46ec.jpg',1,'巧克力/甜品'),
(11,'c210621a-27e2-49ef-bd78-5ad62a2d2f65.jpg',1,'饮料/冲调'),
(12,'2d48b5a9-a8cc-4234-8913-4b8407eed536.jpg',1,'坚果/炒货'),
(13,'72e432d1-089f-4b2b-b1d5-b962084af44c.jpg',1,'熟食/肉类');

/*Table structure for table `oll_addr` */

DROP TABLE IF EXISTS `oll_addr`;

CREATE TABLE `oll_addr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `linkman` varchar(32) NOT NULL,
  `address` varchar(100) NOT NULL,
  `code` varchar(6) NOT NULL,
  `phone` varchar(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_oll_addr_oll_user` (`uid`),
  CONSTRAINT `fk_oll_addr_oll_user` FOREIGN KEY (`uid`) REFERENCES `oll_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `oll_addr` */

insert  into `oll_addr`(`id`,`uid`,`linkman`,`address`,`code`,`phone`) values 
(2,8,'jack','上海市浦东新区','200000','17733333336'),
(4,2,'ww','河南省郑州市','453000','12345678912'),
(5,2,'qq','天津市津南区','222222','2221547896'),
(6,11,'zeng','海南省海口市','112356','123456'),
(8,12,'aa','河南省信阳市','421546','1546812');

/*Table structure for table `oll_admin` */

DROP TABLE IF EXISTS `oll_admin`;

CREATE TABLE `oll_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin` varchar(32) NOT NULL,
  `pass` varchar(32) NOT NULL,
  `addtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin` (`admin`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `oll_admin` */

insert  into `oll_admin`(`id`,`admin`,`pass`,`addtime`) values 
(1,'root','33a48b4b8d6e115ea9d33c69b519e1e3','2017-06-05 09:51:47'),
(2,'admin','dd947f6fdfbb1c8908de3d08f3bd36c3','2017-05-31 17:06:21');

/*Table structure for table `oll_comment` */

DROP TABLE IF EXISTS `oll_comment`;

CREATE TABLE `oll_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `content` text,
  `level` int(1) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `reply` text,
  PRIMARY KEY (`id`),
  KEY `fk_oll_comment_oll_goods` (`gid`),
  KEY `fk_oll_comment_oll_user` (`uid`),
  CONSTRAINT `fk_oll_comment_oll_goods` FOREIGN KEY (`gid`) REFERENCES `oll_goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_oll_comment_oll_user` FOREIGN KEY (`uid`) REFERENCES `oll_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oll_comment` */

/*Table structure for table `oll_goods` */

DROP TABLE IF EXISTS `oll_goods`;

CREATE TABLE `oll_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodsname` varchar(255) NOT NULL,
  `t2id` int(11) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `store` int(11) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  `descr` varchar(255) NOT NULL,
  `sales` int(11) DEFAULT '0',
  `clicknum` int(11) NOT NULL DEFAULT '0',
  `brand` varchar(50) NOT NULL,
  `picname` varchar(255) NOT NULL,
  `equiv` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `goodsname` (`goodsname`),
  KEY `fk_oll_goods_oll_type2` (`t2id`),
  CONSTRAINT `fk_oll_goods_oll_type2` FOREIGN KEY (`t2id`) REFERENCES `oll_type2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

/*Data for the table `oll_goods` */

insert  into `oll_goods`(`id`,`goodsname`,`t2id`,`price`,`store`,`status`,`descr`,`sales`,`clicknum`,`brand`,`picname`,`equiv`) values 
(28,'抹茶蛋糕',4,105.13,366,1,'甜美的杏仁味蛋糕',0,111,'君乐美','8c742de3-ec67-4328-b4c3-03c1c879143e.jpg','125'),
(29,'草梅蛋糕',4,320.01,566,1,'松软可口',0,131,'乐卡夫','1812ceb8-4ef7-47d4-b372-1bd8f09c7dc7.jpeg','1000'),
(30,'提拉米苏',4,450.00,366,1,'带走的不只是美味,还有爱和美味',0,101,'俊乐美','7051a32b-1b9e-4476-b161-f3959a4bbda1.jpg','450'),
(31,'绿豆糕',5,85.00,1200,1,'清凉一夏',0,204,'有成斋','e802d45c-3adc-4d2b-b299-1aef07b11b9b.jpg','75'),
(32,'桃酥',5,25.00,456,1,'酥脆可口',0,202,'杂粮','66eec466-1952-41a5-a334-298c78966dc1.jpg','35'),
(33,'红豆薏仁',50,45.01,899,1,'享受的不止美味,还有健康',0,103,'秹道府','5ba66261-3362-4b8b-93b3-96a657367524.jpg','150'),
(34,'花生牛奶饼',6,35.00,1500,1,'牛奶的丝滑配上花生的美味,简直绝配',0,102,'君乐美','a24dff78-6d7e-4b27-8998-6b3d08c06678.jpg','355'),
(35,'红糖姜味饼干',6,89.00,365,1,'女孩标配',0,102,'小悠饼干铺','befc5be8-b619-4d19-88e1-450c730f8109.jpg','45'),
(36,'农心虾条',8,36.00,566,1,'辣味虾条',0,103,'农心','b49d5dde-7814-4193-968b-345166c289bc.jpg','60'),
(37,'上好佳虾条',8,25.00,899,1,'烧烤味',0,102,'上好佳','40e46eab-93ec-4c72-a368-a69b18d46cdd.jpg','35'),
(39,'上好佳薯片',10,15.00,1500,1,'烧烤味',0,102,'上好佳','50b3a353-e3af-4358-b87c-664663b14999.jpg','50'),
(44,'猪肉脯',11,89.00,200,1,'美味可口',0,108,'清之坊','5b68c434-0f6e-4df9-a27d-255dec6948c9.jpg','120'),
(54,'良品猪肉脯',11,36.00,300,1,'肉肉的召唤',0,231,'维新食品','6238e49a-51e2-40d0-b9de-f72b100af5cf.jpg','45'),
(55,'小香肠',12,35.00,300,1,'广式风味小香肠',0,350,'有成斋','8eaeb0a1-ef92-4a85-87e0-20879b872f09.jpg','300'),
(56,'双汇香肠',12,10.00,566,1,'无淀粉添加双汇香肠',0,380,'双汇','276ee986-cf15-45ec-9521-c59970774fc8.jpg','23'),
(57,'牛肉丝',13,45.12,822,1,'老川东牛肉丝',0,100,'老川东','619955ee-7e03-4180-9d06-e1627ab8b97a.jpg','23'),
(58,'哈哥灯影牛肉丝',13,50.00,455,1,'四川特产牛肉丝',0,140,'四川特产','b4427cc2-159b-4818-853a-3634ef41a39c.jpg','45'),
(61,'三角巧克力',16,125.00,366,1,'瑞士三角巧克力',0,57,'零食铺','862cee1e-8f9e-4901-aa03-b816ca45901f.jpeg','12'),
(62,'豆干',17,25.00,366,1,'香辣豆干',0,101,'大嘴猴','e490a422-1ba5-4a79-ab76-9f4cd950e138.jpg','35'),
(67,'利奥尼达斯薄荷糖',31,68.00,999,1,'利奥尼达斯薄荷糖',0,0,'利奥尼达斯','07997b9a-4313-4165-aacf-f1059f83ff5a.jpg','34'),
(71,'乐事薯片',10,15.00,350,1,'黄瓜味',0,0,'乐事','5c3f17cc-9cca-448c-940b-b9ba26ff019a.jpg','55'),
(72,'纯甄酸牛奶',62,68.00,366,1,'纯甄酸牛奶',0,6,'蒙牛','54f9ba23-6d33-4cbd-96d3-51e674099813.jpg','25'),
(73,'纯牛奶',61,65.00,996,1,'纯牛奶',0,2,'蒙牛','64e2ab1a-09ca-4e06-a416-88e5ce462b34.jpg','36'),
(74,'橙汁',60,25.00,669,1,'新鲜橙汁',0,1,'汇源','fdbd6436-998b-4aca-ba43-bad0228e3538.jpg','35'),
(75,'益生菌牛奶',63,96.00,365,1,'益生菌',0,1,'伊利','8262e3ff-8ab5-490b-a3c2-b5645b98543e.jpg','24'),
(76,'雀巢咖啡',64,65.00,358,1,'速溶咖啡',0,3,'雀巢','de8e88f0-5373-4f7c-975d-09cd9d85ac60.jpg','21'),
(77,'百事可乐',65,5.00,32,1,'可乐',0,0,'百事','286b241f-ee16-4fdd-b360-41d1002e0c38.jpg','500'),
(78,'卤猪肉',75,20.00,655,1,'汝州卤猪肉',0,1,'特产','bc030cd5-ca86-493a-89bc-955d3b6f6635.jpg','300'),
(79,'荣城鸡翅',76,35.00,554,1,'鸡翅',0,0,'特产','0a6e87f9-70f0-4b82-ac59-310dc40d9866.jpg','220'),
(80,'乐山脆皮鸭',77,36.00,558,1,'脆皮鸭',0,0,'特产','0e4ee1e7-a962-46dd-a944-66bbadd5c912.jpg','230'),
(81,'有友',78,25.00,355,1,'笋片',0,2,'特产','3fc54013-c7a5-414a-88ac-64e6408b9ad6.jpg','12'),
(82,'干笋丝',79,65.00,455,1,'笋丝',0,0,'特产','ff515b94-e149-463e-8841-c788404ca9d2.jpg','35'),
(83,'可可味薯片',67,25.00,35,1,'薯片',0,1,'薯片','9e23bcfc-d195-4eda-b094-8302b96cf4c1.jpg','120'),
(84,'开心果',53,85.00,699,1,'精品开心果',0,76,'特产','fa5dbc22-d119-43f0-b281-32e622b0ef99.jpg','36'),
(85,'薄皮核桃',54,99.00,355,1,'营养健康',0,0,'特产','7ed394d9-3c04-4856-90a7-a534645d6691.jpg','25'),
(86,'洽洽瓜子',55,8.00,1025,1,'葵瓜子',0,0,'洽洽','00838d9b-b86a-4e1d-8b6b-5e83c5b3be67.jpg','500'),
(87,'小山哥松子',80,99.00,886,1,'松子',0,0,'特产','5a43f5d8-2b82-44ec-b368-3096ad5fe9ef.jpg','500'),
(88,'夏威夷果',25,89.00,668,1,'坚果',0,80,'特产','81767d97-3595-490b-8083-7230413cc6e5.jpg','300'),
(89,'花生',27,25.00,685,1,'花生',0,3,'特产','9e051cd0-2361-4c3f-b4d4-be5a495f8dda.jpg','500'),
(90,'里奥巧克力',31,155.00,66,1,'巧克力',0,0,'Leonidas/里奥尼达斯','ffc7d4dd-28ac-4878-a7e5-73b86ff4fba8.jpg','500'),
(91,'高迪瓦巧克力',30,142.00,335,1,'巧克力',0,6,'Godiva高迪瓦','5ca26c89-9ce2-494c-84e3-c5f3c550d4ee.jpg','500'),
(92,'普昂沙巧克力',28,135.00,55,1,'巧克力',0,1,'普昂沙Prangins','f4847e35-f2e5-4c03-852b-5dafc5a96536.jpg','500'),
(93,'德芙巧克力',56,65.00,455,1,'巧克力',0,0,'德芙','bd0d71b5-5c08-42a0-a897-4e3bd1055ac2.jpg','500'),
(94,'奶油布丁',41,23.00,56,1,'布丁',0,1,'君乐福','e258b47e-d560-44ab-a1dc-ec1a67a9a652.jpg','500'),
(95,'进口玫瑰花茶',45,55.00,665,1,'玫瑰花茶',0,0,'香草盒子','425cee7c-513b-4135-ba54-984ceb68b49e.jpg','50'),
(96,'莲子芯茶',57,86.00,654,1,'莲子茶',0,1,'徽佰味','08841f32-39e4-4ab5-aebe-990e0fa77e37.jpg','500'),
(97,'黄山贡菊',59,54.00,623,1,'贡菊',0,0,'特产','5cc320bc-99a9-4592-9d4e-db150413fc53.jpg','500'),
(98,'洛神花茶',44,85.00,445,1,'美容养颜',0,4,'美丽说','17ceea3d-9965-41a3-998a-1dc4d78210f9.jpg','35'),
(99,'荷叶茶',58,36.00,689,1,'荷叶茶',0,4,'柏松堂','a035dbbc-377d-42d9-84aa-485cfe9abeba.jpg','500'),
(100,'茉莉花茶',46,42.00,355,1,'清热解毒',0,6,'特产','a954e5f3-7d91-4db4-b85b-0b35099cfd45.jpg','560'),
(101,'奶黄包',51,25.00,35,1,'甜美可口',0,0,'特产','08e96fe8-57a0-466a-9826-d0cc0afb8d9d.jpg','200'),
(103,'菠萝味蛋卷',52,12.00,255,1,'蛋卷',0,3,'君乐福','52f7b699-d378-4f85-9341-d07107bafad6.jpg','500'),
(104,'米多奇膜片',70,5.00,555,1,'香脆可口',0,0,'米多奇','04d8e1b6-22a4-4d2f-928b-35ff0b329da0.jpg','500'),
(105,'忆香街猫耳酥',71,12.00,785,1,'酥脆美味',0,0,'忆香街','037f21ac-85fe-4b08-986f-94be72c9e653.jpg','500'),
(106,'烟熏腊肉',72,150.00,355,1,'舌尖的享受',0,0,'特产','baa92eb5-fca9-49ed-b90e-f220bf2692e5.jpg','500'),
(107,'麻辣小龙虾',74,65.00,55,1,'麻辣',0,0,'特产','5ea5f868-6604-4fd3-bd62-1998bdf7c49a.jpg','500'),
(108,'武汉周黑鸭',73,15.00,550,1,'香辣',0,13,'武汉特产','0d172d74-3419-47ff-ba15-2a05721ee61a.jpg','500'),
(109,'伊利 安慕希',61,75.80,888,1,'伊利 安慕希酸奶 原味 205g*12+4 人民的名义 同款',0,2,'伊利','4f5e6404-6eeb-43e3-924b-b1394b6f2ac1.jpg','205g*12+4'),
(110,'光明莫斯利安',61,86.90,666,1,'光明莫斯利安200g*6盒*4组常温酸奶量贩更优惠',0,4,'光明','c0c6c55c-ba34-493d-b2f2-cd4ec723dd7a.jpg','200g*6盒*4组'),
(111,'蒙牛特仑苏',61,71.99,999,1,'蒙牛特仑苏纯牛奶250ml*16盒新老包装随机发货',0,5,'蒙牛','4d664b79-d480-423f-96c9-ffba10b3fb04.jpg','250ml*16'),
(112,'伊利 金典纯牛奶',61,78.39,888,1,'伊利 金典纯牛奶250ml*16 早餐奶',0,13,'伊利','e745c016-fc2e-4f2c-b5cd-71a2006246dc.jpg','250ml*16'),
(113,'伊利谷粒多红',61,40.00,878,1,'伊利谷粒多红谷苗条装谷物牛奶早餐奶250ml*12盒/提',0,2,'伊利','3b1e495b-40d6-47b2-9d84-3d74878158af.jpg','250ml*12盒/提');

/*Table structure for table `oll_order` */

DROP TABLE IF EXISTS `oll_order`;

CREATE TABLE `oll_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` char(32) NOT NULL,
  `uid` int(11) NOT NULL,
  `addrid` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  `addtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_oll_order_oll_user` (`uid`),
  CONSTRAINT `fk_oll_order_oll_user` FOREIGN KEY (`uid`) REFERENCES `oll_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Data for the table `oll_order` */

insert  into `oll_order`(`id`,`number`,`uid`,`addrid`,`total`,`status`,`addtime`) values 
(19,'164947110601192504',11,NULL,85.00,6,'2017-06-01 19:25:04'),
(30,'134750130602201636',8,NULL,356.00,6,'2017-06-02 20:16:36'),
(31,'693167470602214043',2,NULL,193.00,6,'2017-06-02 21:40:43'),
(33,'14814946120603102950',12,8,89.00,1,'2017-06-03 10:29:51');

/*Table structure for table `oll_order_info` */

DROP TABLE IF EXISTS `oll_order_info`;

CREATE TABLE `oll_order_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) NOT NULL,
  `goodsid` int(11) NOT NULL,
  `num` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_oll_order_info_oll_order` (`orderid`),
  KEY `fk_oll_order_info_oll_goods` (`goodsid`),
  CONSTRAINT `fk_oll_order_info_oll_goods` FOREIGN KEY (`goodsid`) REFERENCES `oll_goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_oll_order_info_oll_order` FOREIGN KEY (`orderid`) REFERENCES `oll_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

/*Data for the table `oll_order_info` */

insert  into `oll_order_info`(`id`,`orderid`,`goodsid`,`num`) values 
(9,19,98,1),
(25,30,88,4),
(26,31,61,1),
(27,31,72,1),
(31,33,88,1);

/*Table structure for table `oll_simg` */

DROP TABLE IF EXISTS `oll_simg`;

CREATE TABLE `oll_simg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL,
  `pic1` varchar(255) NOT NULL,
  `pic2` varchar(255) NOT NULL,
  `pic3` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_oll_img_oll_goods` (`gid`),
  CONSTRAINT `fk_oll_img_oll_goods` FOREIGN KEY (`gid`) REFERENCES `oll_goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oll_simg` */

/*Table structure for table `oll_type1` */

DROP TABLE IF EXISTS `oll_type1`;

CREATE TABLE `oll_type1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `icon` char(30) DEFAULT NULL,
  `picsname` varchar(255) DEFAULT NULL,
  `descr` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `oll_type1` */

insert  into `oll_type1`(`id`,`name`,`icon`,`picsname`,`descr`) values 
(1,'坚果/炒货',NULL,'tj1.png','酥酥脆脆，回味无穷'),
(2,'巧克力/甜品',NULL,'tj2.png','每一道甜品都有一个故事'),
(3,'花茶/果茶',NULL,'4.jpg','清热去火茶'),
(5,'饮料/冲调',NULL,'act1.png','乳酸菌饮品'),
(6,'点心',NULL,'scoll1.png','早餐面包传统美食'),
(7,'饼干/膨化',NULL,'TB2K9IwlSBjpuFj2112500053.jpg','万美猴菇饼干'),
(8,'熟食/肉类',NULL,'TB2CVQmhwxlpuFjSszg2441079062.jpg','卤味肉类熟食'),
(9,'素食/卤味',NULL,'tj.png','手撕拉丝蛋白素牛肉');

/*Table structure for table `oll_type2` */

DROP TABLE IF EXISTS `oll_type2`;

CREATE TABLE `oll_type2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `t1id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `fk_oll_type2_oll_type1` (`t1id`),
  CONSTRAINT `fk_oll_type2_oll_type1` FOREIGN KEY (`t1id`) REFERENCES `oll_type1` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

/*Data for the table `oll_type2` */

insert  into `oll_type2`(`id`,`t1id`,`name`) values 
(4,6,'蛋糕'),
(5,6,'点心'),
(6,7,'饼干'),
(8,7,'虾条'),
(10,7,'薯片'),
(11,8,'猪肉脯'),
(12,8,'小香肠'),
(13,8,'牛肉丝'),
(16,2,'瑞士三角巧克力'),
(17,9,'豆干'),
(25,1,'坚果'),
(27,1,'炒货'),
(28,2,'普昂沙Prangins'),
(30,2,'Godiva高迪瓦'),
(31,2,'Leonidas/里奥尼达斯'),
(41,2,'甜品'),
(44,3,'洛神花茶'),
(45,3,'玫瑰花茶'),
(46,3,'茉莉花茶'),
(50,6,'粥类'),
(51,6,'面点类'),
(52,6,'卷类'),
(53,1,'开心果'),
(54,1,'核桃'),
(55,1,'葵瓜籽'),
(56,2,'德芙巧克力'),
(57,3,'莲子茶'),
(58,3,'荷花减肥茶'),
(59,3,'菊花茶'),
(60,5,'果味饮料 '),
(61,5,'乳品饮料'),
(62,5,'纯甄酸牛奶'),
(63,5,'牛奶'),
(64,5,'咖啡'),
(65,5,'可乐'),
(67,7,'可可味薯片'),
(70,7,'馍干'),
(71,7,'猫耳朵薯片'),
(72,8,'风味腊肉'),
(73,8,'周黑鸭'),
(74,8,'小龙虾熟食'),
(75,9,'汝州卤猪肉'),
(76,9,'荣成鸡翅'),
(77,9,'乐山甜皮鸭'),
(78,9,'泡椒笋片'),
(79,9,'干笋'),
(80,1,'松子');

/*Table structure for table `oll_user` */

DROP TABLE IF EXISTS `oll_user`;

CREATE TABLE `oll_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(32) NOT NULL,
  `pass` char(88) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `addtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `oll_user` */

insert  into `oll_user`(`id`,`account`,`pass`,`status`,`addtime`) values 
(1,'aa','123',1,'2017-05-19 19:00:15'),
(2,'ff','ACP9pCeUmCqREbkJyzeUfkApLhpCjp7trlJU2LoGh1BjnocCoF8YbDN9vnvlTokGPy/gwReOJ977CTQaS8Mygcc=',1,'2017-05-23 12:43:58'),
(3,'jack','123',1,'2017-05-15 09:01:28'),
(4,'李四','123',1,'2017-05-16 09:01:51'),
(5,'kady','19970910',1,'2017-05-27 09:50:48'),
(6,'zhang','1995',1,'2017-05-29 11:05:05'),
(7,'1730350528','123',1,'2017-05-29 15:21:46'),
(8,'hang','AHKIIVAKIiq5r+rlGYmtbfyUX4X9Zt6FQQY5+hrRiyb5WO1I4/CwN+sOBo9/39EoqdVefVS2TU/b+msDuXE7rxM=',1,'2017-05-29 18:57:20'),
(10,'123','AD4AsUCi7371Sb72xd8D29rk6J/WF6uoXzlD3xhxXyAZ0vIA7yt+MNx7KLanHm72a3XhZrKWdHR+vCxBV1tcHgc=',1,'2017-05-31 19:49:44'),
(11,'zeng','AFqbXpq7x5KcWVXlQ4RaZHb3l3EHlenp4AKJOnUZnqyw+/GiJYHLFwcnCxCFVK5KXvNo5dbbT9Q4XXUnLNXjDIw=',1,'2017-06-01 19:24:47'),
(12,'zz','ANazQM4/GUwIC9fOCpq4jvlgpY9vcIsBtTVZ5y6phaUAbEb5ZMZ4d+Z7KyredYnWt8z3Q4pVzi2qRnor+xikHwA=',1,'2017-06-02 14:24:39');

/*Table structure for table `oll_user_info` */

DROP TABLE IF EXISTS `oll_user_info`;

CREATE TABLE `oll_user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `name` char(16) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `pricname` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_oll_user_info_oll_user` (`uid`),
  CONSTRAINT `fk_oll_user_info_oll_user` FOREIGN KEY (`uid`) REFERENCES `oll_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `oll_user_info` */

insert  into `oll_user_info`(`id`,`uid`,`name`,`gender`,`address`,`phone`,`email`,`birth`,`pricname`) values 
(1,8,'jack',1,'河南','18503863016','1968684316@qq.com','2017-06-05',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
