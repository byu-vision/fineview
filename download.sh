#!/bin/bash

#zip crop_undistort.zip --out crop_undistort_split/crop_undistort_split.zip -s 2g

URLs=("ujtsy30prgikz5v2jz3lnilqeme369fe.z01" \ 
      "zbxnd0l578za0feno5bw4qy59rbf6vdk.z02" \ 
      "rwl5cw286fjvx4ayv0s3rutks7jq01v1.z03" \ 
      "hz0chqscek283nkstc4bk6ahwh08q4ds.z04" \ 
      "4phwzm9tmwxou9zd1lybg8d2gvhg40a9.z05" \ 
      "h6bqjkof543gm5mvnbfl8vai7sqxe8x6.z06" \ 
      "qojpgx0kayck5onrh1kiyg2t3dd0z3b2.z07" \ 
      "wcq1pc65axs9cjke7c8ghgmcf34hzo0f.z08" \ 
      "po62f9vx7m2k4etn6ku8ir6cvs68o42v.z09" \ 
      "ty364w3yog6ans62jh18zwnshvc325l1.z10" \ 
      "5vz8rlwu49kcvq04k7ua3bja1atikbri.z11" \ 
      "s70f78dyt9k0ssrqkb8ha1cxxkaepbax.z12" \ 
      "1fnnpygb9eitcft0awa6kv6sz75k21ds.z13" \ 
      "ujjbkujg7m4wkxl8oq5x18gls5aggasx.z14" \ 
      "d342f7qno62rv7g30xkb1fxygyimxov7.z15" \ 
      "l7lz66nb29qh6769kta8a0fz47k7zn93.z16" \ 
      "mcyydn6ax5j28flttbiwrdvmmiu8kkxm.z17" \ 
      "yome4cdp3nizutxfwbaiqikyupug1esc.z18" \ 
      "lp87z6cds14pey6c7nquh6hz28unl44h.z19" \ 
      "6rwegqdgh5thz2hdltca4363q6chqijo.z20" \ 
      "kyuybijmk6flsnr0u02mu5dkhdlexmvr.z21" \ 
      "27shfrkd3zjhm21245vejapsz5cytrgd.z22" \ 
      "zds4rf3h8zy0dk9ylpqylmrigabj6bis.z23" \ 
      "w0a0bkggda2krhcjwx2b5h52dfqy71zt.z24" \ 
      "b9vp134iadkufyi0qo4m20yuy3qjqmow.z25" \ 
      "1gnvt4eursx21x5f6x32tt0eo6wb5dn3.z26" \ 
      "9haelpecb9c7wlbpk773y78jb0piyf8i.z27" \ 
      "vqs92rq2a3x6m57100tpdne6p699bql9.z28" \ 
      "hr86x6yu833g4mzc647z1i4u2eqattey.z29" \ 
      "qwhp6hp3iv6297589xelwow3yce79qm1.z30" \ 
      "pidt6zuoio9laqqsdy5lwakt4m7h1cm9.z31" \ 
      "3trla1sf6smjc23vq4uxikbzrags0ibz.z32" \ 
      "v0mejsitffatmphmeiqtxxp2m1ehwlkk.z33" \ 
      "lms5h31cxpj17pckmp5s1z891e696jd6.z34" \ 
      "oh12t3s4z473vpfx7hvrunnla2ncgxn8.z35" \ 
      "zll3mnxj4o8b7acm9e7ut2a3dzk8hh5n.z36" \ 
      "l1342hdbksyvl4e0eoooskswqwztip2n.z37" \ 
      "pa9tu3qk9a7g67o6ezzyym8t583tlvlz.z38" \ 
      "p19p13w1kfczwx489z9101qm1kzlg6gf.z39" \ 
      "xkl8k3is4peeapjigo32br5tzwlk5flp.z40" \ 
      "xjj9avz1nuc3ptb18os3dnyiec48ill6.z41" \ 
      "0jw2oobrswqakmmyerkq4cumtezz6ajn.z42" \ 
      "onn6lavgfiobkcgr8cjkvqvc4dgeuoys.z43" \ 
      "q5207r51sq9yhivx3l35448b1tlsinqt.z44" \ 
      "gq54g1xzyx7n90hucn0ogaixk730jbil.z45" \ 
      "kvq5566f1p77bycpcafwxkgdiexp2nzl.z46" \ 
      "mqqkx452zi9wdpnftaytbi5tmr76cabe.z47" \ 
      "ntqcn4kbfk0c3a7mxqiyztyn3hkwqc80.z48" \ 
      "4gc2bepowhwkar5no4x3iahye1a4cqrn.z49" \ 
      "0mslqytpj2rc4m0ixtg9wc8p3zspeea7.z50" \ 
      "coh4kzfby6s2pa1sk4474xzjqf8ifawk.z51" \ 
      "vg8kd7nej8z73u0ydvybqznf64gowpmc.z52" \ 
      "8ql9tauow1bn1p9a3xa7cjeqgxpiwf7w.z53" \ 
      "rbo7tudt2wvmstfdnhanl9ptp6zpm2u0.z54" \ 
      "nue4ef9gg9i3n6k421fr772litv4ma7h.z55" \ 
      "kzmcsjmlc02ecu0vrnq9v6jpmudx7fb1.z56" \ 
      "kyzgcmiaqqkni16s1aqlmxzn5mpkr2z6.z57" \ 
      "c0nhlvo718q9srfxaigiet2il8ii3k1h.z58" \ 
      "6kfd2r1fav2njfp8gq10e3vagqnsuzvg.z59" \ 
      "rumy074l408s679ql40amij5l7kv5dyk.z60" \ 
      "er9zcr9drx82npxakhqp8lqjfo7juf2r.z61" \ 
      "b4oiqqxdxw0sadcixtiu8kk7g791jspv.z62" \ 
      "m5zc9he8l1u6rt603uvfannl7wfz6ise.z63" \ 
      "kkkbx1l4b286w2qaah081lu4pzuj7x7d.z64" \ 
      "b162k68jsim930zzm07a03on9cdch86n.z65" \ 
      "93vks01681kkbo4qlwdqfrc1mnrj61zd.z66" \ 
      "d2qnvx0liitdyq0qog1hfz7udv3loqxd.z67" \ 
      "dd8md15quz8sjvujq24tk7npwkxxt8pv.z68" \ 
      "2ttia1erv9w0n5i9mwcf8aedfncawl5u.z69" \ 
      "2m1s9atn61v99d0cp1wdmdysrsece9rh.z70" \ 
      "i8lm2x7kl2bfjboxrci7bttwqr3lpyzy.z71" \ 
      "760kdnjhcs9ti5j2ocsir9c2tiaseob7.z72" \ 
      "ykq6sys306u0ytj1sdhrd0f4ampxhd0a.z73" \ 
      "hx3b799ttx8n0qqoow3qskdo28m06oi5.z74" \ 
      "zt96o9ahj94w22r62pbvefqhfgz2zc8j.z75" \ 
      "953f72ejwzzghwh6nipa57gyx04fp8sw.z76" \ 
      "7vuoebfjh7o7wxfwc7kk1y0itrnldgi5.z77" \ 
      "l8efdjup2ic6grzeg5e1cn71sc6y1gxu.z78" \ 
      "v7fknz880n671v6kwa44xnq53omnsu15.z79" \ 
      "beog93osevkmkm32ggla96jwc4rs6arn.z80" \ 
      "1npsb7qzuj92ou6umz4zpo57lt52wdfz.z81" \ 
      "3no9ns7y3esejts77tqnh7615tlo5b5x.z82" \ 
      "m7k5iw539aee03ighpfj5ufevutxd8j0.z83" \ 
      "gew1uc8nuwwl5shanyfxr4z1gsas2c29.z84" \ 
      "25keve2ad2f49ukmvioz8h3ky1fygii3.z85" \ 
      "yxhy1ci13fvpv3qknbvtmotqj64uekb1.z86" \ 
      "1dpgk6dhupaszr1ugsix1aypohlgcf7x.z87" \ 
      "o8s1uto94aqlzciqprtjly5k3t1xyzt1.z88" \ 
      "0rys4q3qizd11xbdrzobyqa6s369eju5.z89" \ 
      "phxf05hfjatjdruf0hts53usb3qbt74x.z90" \ 
      "8mdgqfkqsp6zm5dto5m4syx0m46jy79f.z91" \ 
      "y5z4npwyfwsg5fcynqxaopjghrtb7ead.z92" \ 
      "sy2c8z68x0j1opgq2rdpbyubfbta0f5n.z93" \ 
      "ojyeuk1bas4ucuxb5pu6sfq8a41mf8q4.z94" \ 
      "qkc8q2gqfuz01clikexo4z2zwpzz6syi.z95" \ 
      "q5rmqnpr65gxrr742u010b7sgf6v62c7.z96" \ 
      "6cjq20v2wxyoqusjcsl59683ph9aqao0.z97" \ 
      "7yvxt5gkxaezwk0240taea1twbmxn2s5.z98" \ 
      "41w4dlu5q78n2uz30w69h1cg3qpmmpz9.z99" \ 
      "cby64mhrxmx1s6jq4fc7092o0vw9o6h1.z100" \ 
      "fhplk0nua8bdq7qhm7x9zy08t6lxon5t.z101" \ 
      "gc1vuwfgyzyrmicz7uv17ne1swb72ck4.zip" \ 
      )

for i in ${URLs[@]}; do
  echo "curl -L https://byu.box.com/shared/static/${i} --output crop_undistort_split.${i##*.}"
  curl -L https://byu.box.com/shared/static/${i} --output crop_undistort_split.${i##*.}
done

zip -s0 crop_undistort_split.zip --out crop_undistort.zip
unzip crop_undistort.zip

curl -L https://byu.box.com/shared/static/9xiusu4mx0obhi26qbv2khnupg03f8zv.zip --output correspondence_undistort.zip
curl -L https://byu.box.com/shared/static/opo6qvxel1dupjqmoo2nfxicmjkowyof.h5 --output camera_parameters.h5
unzip correspondence_undistort.zip

curl -L https://byu.box.com/shared/static/ypvwjkx6ksj3jp1hyq9hh4roq4yj47vf.zip --output crop_mask_undistort.zip
unzip crop_mask_undistort.zip

rm crop_undistort_split.*
rm crop_undistort.zip
rm correspondence_undistort.zip
rm crop_mask_undistort.zip



