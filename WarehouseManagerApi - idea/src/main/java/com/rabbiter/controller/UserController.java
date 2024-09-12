package com.rabbiter.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rabbiter.common.QueryPageParam;
import com.rabbiter.common.Result;
import com.rabbiter.entity.Menu;
import com.rabbiter.entity.User;
import com.rabbiter.service.MenuService;
import com.rabbiter.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;

import java.util.HashMap;
import java.util.List;




@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private MenuService menuService;
private static final String PASS_SALT="zooteamleader";

    @GetMapping("/list")
    public List<User> list(){
        return userService.list();
    }


    @GetMapping("/findByNo")
    public Result findByNo(@RequestParam String no){
        List list = userService.lambdaQuery()
                .eq(User::getNo,no)
                .list();
        return list.size()>0?Result.success(list):Result.fail();
    }


    @PostMapping("/save")
    public Result save(@RequestBody User user){
        if (user.getPassword() != null) {
            String encryptedPassword = SecureUtil.md5(user.getPassword() + PASS_SALT);
            user.setPassword(encryptedPassword);
        } else {
            return Result.fail();
        }
        return userService.save(user)?Result.success():Result.fail();
        //user.setPassword(SecureUtil.md5(user.getPassword()+PASS_SALT));//设置md5加密，加盐
    }


    @PostMapping("/update")
    public Result update(@RequestBody User user){
        user.setPassword(SecureUtil.md5(user.getPassword()+PASS_SALT));//加盐加密
        return userService.updateById(user)?Result.success():Result.fail();
    }


    @PostMapping("/login")
    public Result login(@RequestBody User user){
        //匹配账号和密码
        user.setPassword(SecureUtil.md5(user.getPassword()+PASS_SALT));//加盐加密
        List list = userService.lambdaQuery()
                .eq(User::getNo,user.getNo())
                .eq(User::getPassword,user.getPassword())
                .list();

        if(list.size()>0){
            User user1 = (User)list.get(0);
            List<Menu> menuList = menuService.lambdaQuery()
                    .like(Menu::getMenuright,user1.getRoleId())
                    .list();
            HashMap res = new HashMap();
            res.put("user",user1);
            res.put("menu",menuList);
            return Result.success(res);
        }
        return Result.fail();
    }


    @PostMapping("/mod")
    public boolean mod(@RequestBody User user){
        user.setPassword(SecureUtil.md5(user.getPassword()+PASS_SALT));//加盐加密
        return userService.updateById(user);
    }

    @PostMapping("/saveOrUpdate")
    public Result saveOrUpdate(@RequestBody User user){
        user.setPassword(SecureUtil.md5(user.getPassword()+PASS_SALT));//加盐加密
        return userService.saveOrUpdate(user)?Result.success():Result.fail();
    }


    @GetMapping("/del")
    public Result delete(Integer id){
        return userService.removeById(id)?Result.success():Result.fail();
    }

    @PostMapping("/listP")
    public Result query(@RequestBody User user){
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        if(StringUtils.isNotBlank(user.getName())){
            wrapper.like(User::getName,user.getName());
        }
        return Result.success(userService.list(wrapper));
    }


//    @PostMapping("/listPage")
//    public Result page(@RequestBody QueryPageParam query){
//        HashMap param = query.getParam();
//        String name = (String)param.get("name");
//
//        Page<User> page = new Page();
//        page.setCurrent(query.getPageNum());
//        page.setSize(query.getPageSize());
//
//        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
//        wrapper.like(User::getName,name);
//
//        IPage result = userService.page(page,wrapper);
//        return Result.success(result.getRecords(),result.getTotal());
//    }

    @PostMapping("/listPage")
    public List<User> listPage(@RequestBody QueryPageParam query){
        HashMap param = query.getParam();
        String name = (String)param.get("name");
        System.out.println("name=>"+(String)param.get("name"));

        Page<User> page = new Page();
        page.setCurrent(query.getPageNum());
        page.setSize(query.getPageSize());

        LambdaQueryWrapper<User> lambdaQueryWrapper = new LambdaQueryWrapper();
        lambdaQueryWrapper.like(User::getName,name);


        IPage result = userService.page(page,lambdaQueryWrapper);

        System.out.println("total=>"+result.getTotal());

        return result.getRecords();
    }

    @PostMapping("/listPageC1")
    public Result listPageC1(@RequestBody QueryPageParam query){
        HashMap param = query.getParam();
        String name = (String)param.get("name");
        String sex = (String)param.get("sex");
        String roleId = (String)param.get("roleId");

        Page<User> page = new Page();
        page.setCurrent(query.getPageNum());
        page.setSize(query.getPageSize());

        LambdaQueryWrapper<User> lambdaQueryWrapper = new LambdaQueryWrapper();
        if(StringUtils.isNotBlank(name) && !"null".equals(name)){
            lambdaQueryWrapper.like(User::getName,name);
        }
        if(StringUtils.isNotBlank(sex)){
            lambdaQueryWrapper.eq(User::getSex,sex);
        }
        if(StringUtils.isNotBlank(roleId)){
            lambdaQueryWrapper.eq(User::getRoleId,roleId);
        }

        IPage result = userService.pageCC(page,lambdaQueryWrapper);

        System.out.println("total=>"+result.getTotal());

        return Result.success(result.getRecords(),result.getTotal());
    }

}
