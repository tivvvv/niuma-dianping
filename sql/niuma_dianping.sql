DROP TABLE IF EXISTS `tb_blog`;
CREATE TABLE `tb_blog`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `shop_id`     bigint(20) NOT NULL COMMENT '商户id',
    `user_id`     bigint(20) NOT NULL COMMENT '用户id',
    `title`       varchar(255) NOT NULL COMMENT '标题',
    `images`      varchar(2048) NOT NULL COMMENT '探店照片',
    `content`     varchar(2048) NOT NULL COMMENT '探店内容',
    `liked`       int(8) DEFAULT 0 COMMENT '点赞数量',
    `comments`    int(8) DEFAULT 0 COMMENT '评论数量',
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT ='探店博客表';

DROP TABLE IF EXISTS `tb_blog_comments`;
CREATE TABLE `tb_blog_comments`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id`     bigint(20) NOT NULL COMMENT '用户id',
    `blog_id`     bigint(20) NOT NULL COMMENT '探店博客id',
    `parent_id`   bigint(20) NOT NULL COMMENT '一级评论id',
    `answer_id`   bigint(20) NOT NULL COMMENT '回复的评论id',
    `content`     varchar(255) NOT NULL COMMENT '评论内容',
    `liked`       int(8) DEFAULT 0 COMMENT '点赞数',
    `status`      tinyint(1) DEFAULT NULL COMMENT '状态,0:正常 1:被举报 2:禁止查看',
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT ='博客评论表';

DROP TABLE IF EXISTS `tb_follow`;
CREATE TABLE `tb_follow`
(
    `id`             bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id`        bigint(20) NOT NULL COMMENT '用户id',
    `follow_user_id` bigint(20) NOT NULL COMMENT '关注的用户id',
    `create_time`    timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT ='关注表';

DROP TABLE IF EXISTS `tb_seckill_voucher`;
CREATE TABLE `tb_seckill_voucher`
(
    `voucher_id`  bigint(20) NOT NULL COMMENT '关联的优惠券的id',
    `stock`       int(8) NOT NULL COMMENT '库存',
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `begin_time`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生效时间',
    `end_time`    timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '失效时间',
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`voucher_id`)
) COMMENT = '秒杀优惠券表';

DROP TABLE IF EXISTS `tb_shop`;
CREATE TABLE `tb_shop`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(128) NOT NULL COMMENT '商铺名称',
    `type_id`     bigint(20) NOT NULL COMMENT '商铺类型的id',
    `images`      varchar(1024) NOT NULL COMMENT '商铺图片',
    `area`        varchar(128) DEFAULT NULL COMMENT '商圈',
    `address`     varchar(255) NOT NULL COMMENT '地址',
    `x`           double NOT NULL COMMENT '经度',
    `y`           double NOT NULL COMMENT '维度',
    `avg_price`   bigint(10) DEFAULT NULL COMMENT '均价',
    `sold`        int(10) NOT NULL COMMENT '销量',
    `comments`    int(10) NOT NULL COMMENT '评论数量',
    `score`       int(2) NOT NULL COMMENT '评分',
    `open_hours`  varchar(32) DEFAULT NULL COMMENT '营业时间',
    `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX `foreign_key_type`(`type_id`)
) COMMENT ='店铺表';

DROP TABLE IF EXISTS `tb_shop_type`;
CREATE TABLE `tb_shop_type`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(32) DEFAULT NULL COMMENT '类型名称',
    `icon`        varchar(255) DEFAULT NULL COMMENT '图标',
    `sort`        int(3) DEFAULT NULL COMMENT '顺序',
    `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT ='店铺类型';

DROP TABLE IF EXISTS `tb_sign`;
CREATE TABLE `tb_sign`
(
    `id`        bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id`   bigint(20) NOT NULL COMMENT '用户id',
    `year` year NOT NULL COMMENT '签到的年',
    `month`     tinyint(2) NOT NULL COMMENT '签到的月',
    `date`      date NOT NULL COMMENT '签到的日',
    `is_backup` tinyint(1) DEFAULT NULL COMMENT '是否补签',
    PRIMARY KEY (`id`)
) COMMENT ='签到表';

DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `phone`       varchar(11) NOT NULL COMMENT '手机号码',
    `password`    varchar(128) NULL DEFAULT '' COMMENT '密码',
    `nick_name`   varchar(32) NULL DEFAULT '' COMMENT '昵称',
    `icon`        varchar(255) NULL DEFAULT '' COMMENT '头像',
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE INDEX `uniqe_key_phone` (`phone`)
) COMMENT ='用户表';

DROP TABLE IF EXISTS `tb_user_info`;
CREATE TABLE `tb_user_info`
(
    `user_id`     bigint(20) NOT NULL COMMENT '主键',
    `city`        varchar(64) NULL DEFAULT '' COMMENT '城市名称',
    `introduce`   varchar(128) DEFAULT NULL COMMENT '个人介绍',
    `fans`        int(8) NULL DEFAULT 0 COMMENT '粉丝数量',
    `followee`    int(8) NULL DEFAULT 0 COMMENT '关注的人的数量',
    `gender`      tinyint(1) NULL DEFAULT 0 COMMENT '性别,0:男 1:女',
    `birthday`    date DEFAULT NULL COMMENT '生日',
    `credits`     int(8) NULL DEFAULT 0 COMMENT '积分',
    `level`       tinyint(1) NULL DEFAULT 0 COMMENT '会员级别',
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`user_id`)
) COMMENT ='用户信息表';

DROP TABLE IF EXISTS `tb_voucher`;
CREATE TABLE `tb_voucher`
(
    `id`           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `shop_id`      bigint(20) DEFAULT NULL COMMENT '商铺id',
    `title`        varchar(255) NOT NULL COMMENT '代金券标题',
    `sub_title`    varchar(255) DEFAULT NULL COMMENT '副标题',
    `rules`        varchar(1024) DEFAULT NULL COMMENT '使用规则',
    `pay_value`    bigint(10) NOT NULL COMMENT '支付金额/分',
    `actual_value` bigint(10) NOT NULL COMMENT '抵扣金额/分',
    `type`         tinyint(1) NOT NULL DEFAULT 0 COMMENT '0:普通券 1:秒杀券',
    `status`       tinyint(1) NOT NULL DEFAULT 1 COMMENT '1:上架 2:下架 3:过期',
    `create_time`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT ='优惠券表';

DROP TABLE IF EXISTS `tb_voucher_order`;
CREATE TABLE `tb_voucher_order`
(
    `id`          bigint(20) NOT NULL COMMENT '主键',
    `user_id`     bigint(20) NOT NULL COMMENT '下单的用户id',
    `voucher_id`  bigint(20) NOT NULL COMMENT '购买的代金券id',
    `pay_type`    tinyint(1) NOT NULL DEFAULT 1 COMMENT '支付方式 1:余额支付 2:支付宝 3:微信',
    `status`      tinyint(1) NOT NULL DEFAULT 1 COMMENT '订单状态,1:未支付 2:已支付 3:已核销 4:已取消 5:退款中 6:已退款',
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
    `pay_time`    timestamp DEFAULT NULL COMMENT '支付时间',
    `use_time`    timestamp DEFAULT NULL COMMENT '核销时间',
    `refund_time` timestamp DEFAULT NULL COMMENT '退款时间',
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT ='优惠券订单表';

