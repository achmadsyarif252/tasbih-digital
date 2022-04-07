/*
Data untuk dzikir setelah sholat
 */
const DZIKIR_SHOLAT = [
  {
    'arab':
        'أَسْتَغْفِرُ اللهَ الْعَظِـيْمِ الَّذِيْ لَااِلَهَ اِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ وَأَتُوْبُ إِلَيْهِ',
    'latin':
        'Astaghfirullaahal-Adziim, Alladzii Laa Ilaaha Illaa Huwalhayyul-Qayyuum, Wa Atuubu Ilaiih. (Dibaca Sebanya 3 X)',
    'arti':
        'Saya mohon ampun kepada allahyang maha besar, tidak ada tuhan melainkan dia, yang maha hidup yang terus-menerus mengurus makhluknya, dan saya bertobat kepadanya',
  },
  {
    'arab':
        'لَااِلَهَ اِلَّا اللهُ وَحْدَهُ لَاشَرِيْكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِ وَيُمِيْتُ وَهُوَ عَلَى كُلِّ شَيْئٍ قَدِيْر',
    'latin':
        'Laa ilaha illallah wahdahu laa syarika lah, lahul mulku wa lahul hamdu wa huwa ‘ala kulli syai-in qodiir (Dibaca Sebanya 3 X)',
    'arti':
        'Tidak ada yang berhak disembah selain Allah. Dia Yang Maha Tunggal tidak ada sekutu bagi-Nya. Milik-Nya kerajaan dan bagi-Nya segala puji dan Dia Maha Kuasa atas segala sesuatu',
  },
  {
    'arab': 'اَللَّهُمَّ أَجِرْنِـى مِنَ النَّارِ',
    'latin': 'Allohumma ajirnii minanar dibaca 3 x',
    'arti': 'Ya Allah, lindungilah aku dari api neraka',
  },
  {
    'arab':
        'اَللَّهُمَّ لاَ مَانِعَ لِمَا أَعْطَيْتَ وَلاَ مُعْطِيَ لِمَا مَنَعْتَ وَلاَ يَنْفَعُ ذَا الْجَدِّ مَنْكَ الْجَدُّ, لاَ إِلَهَ إِلاَّ أَنْتَ',
    'latin':
        'Allahumma la mani a lima a thaita wa la mu’thiya lima mana’ta wa la yanfa’u dzal jadii minkal jaddu, la ilaha illa anta.',
    'arti':
        'Ya Allah tidak ada yang menghalangi bagi apa yang telah Engkau berikan dan tidak kepada orang yang kaya di sisi Engkau segala kekayaanya selain dari kebesaran-Mu ya Rabb. Tidak ada Tuhan yang layak disembah selain Engkau.'
  },
  {
    'arab':
        'للَّهُمَّ أَنْتَ السَّلاَمُ، وَمِنْكَ السَّلَامُ، وَإِلَيْكَ يَعُوْدُ السَّلَامُ فَحَيِّنَارَبَّنَا بِالسَّلَامِ وَاَدْخِلْنَا الْـجَنَّةَ دَارَ السَّلَامِ تَبَارَكْتَ رَبَّنَا وَتَعَالَيْتَ يَا ذَاالْـجَلَالِ وَاْلإِكْرَام.',
    'latin':
        'Allahumma Antas-Salaamu Wamingkas-Salaamu Wa Ilaika Ya Uudus-Salaamu Fa Hayyinaa Rabbanaa Bis-Salaami Wa Adkhilna-Jannata Daaros-Salaami Tabaarokta Robbanaa Wa Ta Aalaita Ya Dzal-Jalaali Wal Ikroom',
    'arti':
        'Ya allah, engkau adalah zat yang mempunyaikesejahtraan dan daripadamulah kesejahtraan itu da kepadamulah akan kembali lagi segala kesejahtraan itu, maka hidupkanlah kami ya allah dengan sejahtera. dan masukanlah kami kedalam surga kampung kesejahtraan, engkaulah yang kuasa memberi berkah yang banyak dan engkaulah yang maha tinggi, wahai zat yang memiliki ke agungan dan kemulyaan.',
  },
  {
    'arab':
        'أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ: بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ ﴿١﴾ الْحَمْدُ لِلَّـهِ رَبِّ الْعَالَمِينَ ﴿٢﴾ الرَّحْمَـٰنِ الرَّحِيمِ ﴿٣﴾ مَالِكِ يَوْمِ الدِّينِ ﴿٤﴾إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ﴿٥﴾ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ﴿٦﴾صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ ﴿٧﴾ أمين',
    'latin':
        'A’udzu Billahiminas Syaitho Nirrojiim. Bismillahir rohmanirro’hiim. Al’hamdulillahi robbil’aalamiin. Arro’hmanirro’him. Maliki Yawmiddiin. Iyyaka Na’budu Wa Iyyaka Nasta’iin. Ihdinash-Shiro Tholmustaqiim. Shirotholladziina An’amta ‘Alaihim Ghoiril maghdhuubi ‘Alaihim Wala Dholiin. Aamiin.',
    'arti': ''
  },
  {
    'arab':
        'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ. بِسْمِ اللهِ الرَّحْمَنِ الرَّحِيْمِ. اَللهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَّلَانَوْمٌ، لَهُ مَافِي السَّمَاوَاتِ وَمَافِي اْلأَرْضِ مَن ذَا الَّذِيْ يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَابَيْنَ أَيْدِيْهِمْ وَمَاخَلْفَهُمْ وَلَا يُحِيْطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَآءَ، وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَاْلأَرْضَ وَلَا يَـؤدُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيْمُ.',
    'latin':
        'Allahu laa ilaaha illaa huwal hayyul qayyum. Laa ta\'khudzuhuu sinatuw wa laa naum. Lahuu maa fis samaawaati wa maa fil ardh. Man dzal ladzii yasyfa\'u \'indahuu illaa bi idznih. Ya\'lamu maa bayna aidiihim wa maa khalfahum. Wa laa yuhiithuuna bi syai-im min\'ilmihii illaa bimaa syaa-a. Wasi\'a kursiyyuhus samaawaati wal ardh walaa ya-uuduhuu hifzhuhumaa Wahuwal\'aliyyul\'azhiim.',
    'arti':
        'Allah, tidak ada tuhan selain dia, yang maha hidup, yang terus menerus mengurus (makhluknya), tidak mengantuk dan tidak tidur, miliknya apa yang ada di langit dan apa yang ada di bumi, tidak ada yang dapat memberi syafaat disisinya tanpa izinnya. dia mengetahui apa yang ada dihadapan mereka dan apa yang di belakang mereka, dan mereka tidak mengetahui sesuatu apapun tentang ilmunya melainkan apa yang dia kehendaki, kursinya meliputi langit dan bumi. dan dia tidak merasa berat memelihara keduanya, dan dia maha tinggi, maha besar.',
  },
  {
    'arab':
        'شَهِدَ اللّٰهُ اَنَّهٗ لَآ اِلٰهَ اِلَّا هُوَۙ وَالْمَلٰۤىِٕكَةُ وَاُولُوا الْعِلْمِ قَاۤىِٕمًاۢ بِالْقِسْطِۗ لَآ اِلٰهَ اِلَّا هُوَ الْعَزِيْزُ الْحَكِيْمُ اِنَّ الدِّيْنَ عِنْدَ اللّٰهِ الْاِسْلَامُۗ وَمَا اخْتَلَفَ الَّذِيْنَ اُوْتُوا الْكِتٰبَ اِلَّا مِنْۢ بَعْدِ مَا جَاۤءَهُمُ الْعِلْمُ بَغْيًاۢ بَيْنَهُمْۗ وَمَنْ يَّكْفُرْ بِاٰيٰتِ اللّٰهِ فَاِنَّ اللّٰهَ سَرِيْعُ الْحِسَابِ',
    'latin': '',
    'arti':
        'Allah menyatakan bahwasanya tidak ada tuhan (yang berhak disembah) melainkan Dia, Yang menegakkan keadilan. Para Malaikat dan orang-orang yang berilmu (juga menyatakan yang demikian itu). Tak ada Ilah (yang berhak disembah) melainkan Dia, Yang Maha Perkasa lagi Maha Bijaksana.',
  },
  {
    'arab': 'سُبْحَانَ اللهِ ×٣٣',
    'latin': 'Subhanallah (33x)',
    'arti': 'Mahasuci Allah',
  },
  {
    'arab': 'اَلْحَمْدُلِلهِ ×٣٣',
    'latin': 'Alhamdulillah (33x)',
    'arti': 'Segala puji bagi Allah',
  },
  {
    'arab': 'اَللهُ اَكْبَرْ ×٣٣',
    'latin': 'Allahuakbar (33x)',
    'arti': 'Allah maha besar'
  },
  {
    'arab':
        ' ِاللهُ اَكْبَرُ كَبِيْرَا وَالْحَمْدُ للهِ كَثِيْرًا وَسُبْحَانَ اللهِ بُكْرَةً وَأَصِيْلًا لَااِلَهَ اِلَّا اللهُ وَحْدَهُ لَاشَرِيْكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِ وَيُمِيْتُ وَهُوَ عَلَى كُلِّ شَيْئٍ قَدِيْرٌ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ الْعَلِيِّ الْعَظِيْ',
    'latin':
        'Allohu Akbar Kabiiron Wal’hamdulillahi Katsiiron Wasub’hanallohi Bukrotan Wa Ashiilan, LaaIlaha Illallohu Wa’hdahula Syariikalah Lahulmulku Walahul’hamdu Yu’hyii Wayumiitu Wahuwa ‘Ala Kulli Syai Inqodiir. Wala’Hawla Wala Quwwata Illa Billahil ‘Aliyyil’adzhiim.',
    'arti': '',
  },
];
