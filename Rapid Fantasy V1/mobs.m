%out=mob(h,mh,m,mm,s,w,d,l,i,n,e,g,ex,id,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
Mob1=mob(39,39,10,10,8,8,5,1,imread('Mob1_img.png'),'Slime',2,50,180,1,[],[],[],[],[]);
Mob1.Atk1=mobatk('Bounce',2*Mob1.Strength,0);

Mob2=mob(50,50,8,8,7,7,8,1,imread('Mob2_img.png'),'Rocky',4,70,200,2,[],[],[],[],[]);
Mob2.Atk1=mobatk('Rock throw',2*Mob2.Strength,0);

Mob3=mob(48,48,15,15,5,10,5,1,imread('Mob3_img.png'),'Mushroom',4,55,250,3,[],[],[],[],[]);
Mob3.Atk2=mobatk('Hallucinate',2*Mob3.Wisdom,5);
Mob3.Atk1=mobatk('Spores',round(2.5*Mob3.Strength),0);

Mob4=mob(72,72,10,10,13,10,8,2,imread('Mob4_img.png'),'Duck',3,100,1000,4,[],[],[],[],[]);
Mob4.Atk1=mobatk('Tackle',round(2*Mob4.Strength),0);
Mob4.Atk2=mobatk('Explosion',3*Mob4.Wisdom,4);

Mob5=mob(96,96,15,15,10,15,10,2,imread('Mob5_img.png'),'Triple A battery',5,80,1200,5,[],[],[],[],[]);
Mob5.Atk1=mobatk('Hit',2*Mob5.Strength,0);
Mob5.Atk2=mobatk('Spark',2*Mob5.Wisdom,5);

Mob6=mob(156,156,15,15,28,22,15,3,imread('Mob6_img.png'),'Skeleton',8,125,2700,6,[],[],[],[],[]);
Mob6.Atk1=mobatk('Bone Crush',2*Mob6.Strength,0);
Mob6.Atk2=mobatk('Curse',2*Mob6.Wisdom,5);

Mob7=mob(135,135,20,20,20,28,14,3,imread('Mob7_img.png'),'Mixtape',3,150,3200,7,[],[],[],[],[]);
Mob7.Atk3=mobatk('Drop The Beat',2*Mob7.Wisdom,7);
Mob7.Atk2=mobatk('Lay A Verse',round(1.8*Mob7.Wisdom),4);
Mob7.Atk1=mobatk('Tangle',2*Mob7.Strength,0);

Mob8=mob(304,304,20,20,52,40,25,4,imread('Mob8_img.png'),'Squirrel',2,200,4500,8,[],[],[],[],[]);
Mob8.Atk1=mobatk('Bite',2*Mob8.Strength,0);
Mob8.Atk2=mobatk('Gnaw',round(1.5*Mob8.Strength),0);
Mob8.Atk3=mobatk('Acornucopia of pain',2*Mob8.Wisdom,5);

Mob9=mob(273,273,30,30,37,54,24,4,imread('Mob9_img.png'),'Book',7,225,5800,9,[],[],[],[],[]);
Mob9.Atk1=mobatk('Body Slam',2*Mob9.Strength,0);
Mob9.Atk2=mobatk('Confusion',2*Mob9.Wisdom,6);
Mob9.Atk3=mobatk('Face the Book',round(2.2*Mob9.Strength),0);

Mob10=mob(513,513,30,30,70,70,36,5,imread('Mob10_img.png'),'Battery Rat',5,300,12500,10,[],[],[],[],[]);
Mob10.Atk1=mobatk('Thunder Punch',2*Mob10.Strength,0);
Mob10.Atk2=mobatk('Thunder Shock',2*Mob10.Wisdom,10);
Mob10.Atk3=mobatk('Thunder Wave',round(1.8*Mob10.Wisdom),5);

Mob11=mob(472,472,40,40,93,68,34,5,imread('Mob11_img.png'),'Penguin',6,350,12500,11,[],[],[],[],[]);
Mob11.Atk3=mobatk('Water Gun',2*Mob11.Wisdom,8);
Mob11.Atk2=mobatk('Doot Doot',2*Mob11.Strength,0);
Mob11.Atk1=mobatk('Peck',round(1.8*Mob11.Strength),0);
%out=mob(h,mh,m,mm,s,w,d,l,i,n,e,g,ex,id,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
%Jetpack - Magical
Mob12=mob(576,576,100,100,92,117,45,5,imread('Mob12_img.png'),'Emperor Penguin',03,0,0,12,[],[],[],[],[]);
Mob12.Atk1=mobatk('Wing',2*Mob12.Strength,0);
Mob12.Atk2=mobatk('Ignition',2*Mob12.Wisdom,5);
Mob12.Atk3=mobatk('Peck',round(2.2*Mob12.Strength),0);
Mob12.Atk4=mobatk('Flamethrower',round(2.2*Mob12.Wisdom),12);

%Balloon - Physical
Mob13=mob(645,645,50,50,118,90,50,5,imread('Mob13_img.png'),'Emperor Penguin',05,0,0,13,[],[],[],[],[]);
Mob13.Atk1=mobatk('Static Peck',2*Mob13.Strength,0);
Mob13.Atk2=mobatk('Shock Volt',2*Mob13.Wisdom,5);
Mob13.Atk3=mobatk('Tesla Contact',round(2.2*Mob13.Strength),0);
Mob13.Atk4=mobatk('Monarch''s Thunder',round(2.2*Mob13.Wisdom),7);

%Landed - Percentile
Mob14=mob(304,304,100,100,78,80,55,5,imread('Mob14_img.png'),'Emperor Penguin',06,1000000,1000000,14,[],[],[],[],[]);
Mob14.Atk1=mobatk('Frigid Onslaught',round(2.5*Mob14.Strength),0);
Mob14.Atk2=mobatk('Tsunami',round(2.5*Mob14.Wisdom),7);
Mob14.Atk3=mobatk('Royal Decree',0.50*Player.MaxHealth,30);