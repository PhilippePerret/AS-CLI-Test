FasdUAS 1.101.10   ��   ��    k             j     �� �� *0 titrefenetreclitest titreFenetreCLITest  m        � 	 	  F e n e t r e C L I T e s t   
  
 j    �� �� "0 commandfilepath commandFilePath  m    ��
�� 
null      l     ��������  ��  ��        l      ��  ��    + %
	Je dois recevoir le code � tester
	     �   J 
 	 J e   d o i s   r e c e v o i r   l e   c o d e   �   t e s t e r 
 	      i    	    I     �� ��
�� .aevtodocnull  �    alis  l      ����  o      ���� 0 args  ��  ��  ��    X      ��   I    �� ���� 0 lance_et_analyse_test     ��  o    ���� 0 f  ��  ��  �� 0 f    o    ���� 0 args        l     ��������  ��  ��       !   l      �� " #��   " 4 .
	Pour terminer, on appelle le script qui va 
    # � $ $ \ 
 	 P o u r   t e r m i n e r ,   o n   a p p e l l e   l e   s c r i p t   q u i   v a   
 !  % & % i   
  ' ( ' I      �������� 
0 finish  ��  ��   ( k      ) )  * + * l     �� , -��   , U O TODO On doit enregistrer le contenu du terminal dans un fichier au m�me niveau    - � . . �   T O D O   O n   d o i t   e n r e g i s t r e r   l e   c o n t e n u   d u   t e r m i n a l   d a n s   u n   f i c h i e r   a u   m � m e   n i v e a u +  / 0 / l     �� 1 2��   1   que le fichier test�    2 � 3 3 *   q u e   l e   f i c h i e r   t e s t � 0  4 5 4 I     �������� >0 savecontentofsimulationwindow saveContentOfSimulationWindow��  ��   5  6 7 6 l   ��������  ��  ��   7  8�� 8 O     9 : 9 I  
 �� ;��
�� .coredoscnull��� ��� ctxt ; b   
  < = < b   
  > ? > m   
  @ @ � A A | r u b y   / U s e r s / p h i l i p p e p e r r e t / P r o g r a m m e s / A S - C L I - T e s t / c h e c k e r . r b   ' ? o    ���� "0 commandfilepath commandFilePath = m     B B � C C  '��   : m     D D�                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��  ��   &  E F E l     ��������  ��  ��   F  G H G i     I J I I      �������� >0 savecontentofsimulationwindow saveContentOfSimulationWindow��  ��   J k     > K K  L M L l     ��������  ��  ��   M  N O N l     �� P Q��   P B <	set resultatFile to (commandFilePath & ".result") as string    Q � R R x 	 s e t   r e s u l t a t F i l e   t o   ( c o m m a n d F i l e P a t h   &   " . r e s u l t " )   a s   s t r i n g O  S T S l     �� U V��   U B <display dialog "Le fichier r�sultat est � : " & resultatFile    V � W W x d i s p l a y   d i a l o g   " L e   f i c h i e r   r � s u l t a t   e s t   �   :   "   &   r e s u l t a t F i l e T  X Y X r      Z [ Z m      \ \ � ] ] r / U s e r s / p h i l i p p e p e r r e t / P r o g r a m m e s / A S - C L I - T e s t / r e s u l t a t . t x t [ o      ���� 0 resultatfile resultatFile Y  ^ _ ^ l   ��������  ��  ��   _  ` a ` O     b c b O     d e d r     f g f c     h i h l    j���� j n     k l k 1    ��
�� 
pcnt l  g    ��  ��   i m    ��
�� 
TEXT g o      ���� "0 resultatcontent resultatContent e n     m n m 4   �� o
�� 
ttab o m    ����  n 4   �� p
�� 
cwin p m   
 ����  c m     q q�                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��   a  r s r l   ��������  ��  ��   s  t u t r    " v w v 4     �� x
�� 
psxf x o    ���� 0 resultatfile resultatFile w o      ���� 0 resultatfile resultatFile u  y z y r   # , { | { I  # *�� } ~
�� .rdwropenshor       file } o   # $���� 0 resultatfile resultatFile ~ �� ��
�� 
perm  m   % &��
�� boovtrue��   | o      ���� 0 myfile myFile z  � � � I  - 6�� � �
�� .rdwrwritnull���     **** � o   - .���� "0 resultatcontent resultatContent � �� � �
�� 
refn � o   / 0���� 0 myfile myFile � �� ���
�� 
as   � m   1 2��
�� 
utf8��   �  � � � I  7 <�� ���
�� .rdwrclosnull���     **** � o   7 8���� 0 myfile myFile��   �  ��� � l  = =��������  ��  ��  ��   H  � � � l     ��������  ��  ��   �  � � � i     � � � I      �� ����� ,0 runcommandinterminal runCommandInTerminal �  ��� � o      ���� 0 command  ��  ��   � k     r � �  � � � Z      � ����� � I     �������� "0 noclitestwindow noCLITestWindow��  ��   � I    �������� 0 make_a_clitest_window  ��  ��  ��  ��   �  � � � O    ' � � � O    & � � � r     % � � � n     # � � � 1   ! #��
�� 
busy �  g     ! � o      ���� 0 isbusy isBusy � n     � � � 4   �� �
�� 
ttab � m    ����  � n     � � � 4   �� �
�� 
cwin � m    ����  � m     � ��                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��   � m     � ��                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��   �  � � � O   ( R � � � k   , Q � �  � � � O   , 9 � � � I  3 8������
�� .miscactvnull��� ��� null��  ��   � 4   , 0�� �
�� 
prcs � m   . / � � � � �  t e r m i n a l �  ��� � Z   : Q � ����� � o   : ;���� 0 isbusy isBusy � k   > M � �  � � � l  > >�� � ���   � J D On repart du d�part s'il y a un script en route (sauf contre ordre)    � � � � �   O n   r e p a r t   d u   d � p a r t   s ' i l   y   a   u n   s c r i p t   e n   r o u t e   ( s a u f   c o n t r e   o r d r e ) �  � � � I  > G�� � �
�� .prcskprsnull���     ctxt � m   > ? � � � � �  c � �� ���
�� 
faal � J   @ C � �  ��� � m   @ A��
�� eMdsKctl��  ��   �  ��� � I  H M�� ���
�� .sysodelanull��� ��� nmbr � m   H I � � ?�      ��  ��  ��  ��  ��   � m   ( ) � ��                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   �  � � � l  S S�������  ��  �   �  ��~ � O   S r � � � k   W q � �  � � � I  W \�}�|�{
�} .miscactvnull��� ��� null�|  �{   �  � � � l  ] ]�z � ��z   � 2 , display dialog "Je dois jouer : " & command    � � � � X   d i s p l a y   d i a l o g   " J e   d o i s   j o u e r   :   "   &   c o m m a n d �  ��y � O   ] q � � � I  g p�x � �
�x .coredoscnull��� ��� ctxt � o   g h�w�w 0 command   � �v ��u
�v 
kfil �  g   k l�u   � n   ] d � � � 4  a d�t �
�t 
ttab � m   b c�s�s  � 4  ] a�r �
�r 
cwin � m   _ `�q�q �y   � m   S T � ��                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��  �~   �  � � � l     �p�o�n�p  �o  �n   �  � � � i     � � � I      �m ��l�m 0 realkeyfrom realKeyFrom �  ��k � o      �j�j 0 k  �k  �l   � Z     5 � � � � � =     � � � o     �i�i 0 k   � m     � � � � �  A R R O W _ D O W N � L     � � m    �h�h } �  � � � =    � � � o    �g�g 0 k   � m     � � � � �  R E T U R N �  ��f � L     � � m    �e�e $�f   � k    5 � �  � � � O    2   k    1  I   �d�c�b
�d .miscactvnull��� ��� null�c  �b   �a I    1�`�_
�` .sysodlogaskr        TEXT b     - l    +	�^�]	 c     +

 b     ) b     % b     # m     ! � ( J e   n ' a i   p a s   t r o u v �   ' o   ! "�\�\ 0 k   m   # $ �  '   d e   c l a s s e   ' l  % (�[�Z n   % ( m   & (�Y
�Y 
pcls o   % &�X�X 0 k  �[  �Z   m   ) *�W
�W 
ctxt�^  �]   m   + , � < '   d o n c   j e   l e   r e n v o i e   t e l   q u e l .�_  �a   m    �                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��   � �V l  3 5 L   3 5   o   3 4�U�U 0 k     par exemple un texte    �!! *   p a r   e x e m p l e   u n   t e x t e�V   � "#" l     �T�S�R�T  �S  �R  # $%$ i    &'& I      �Q(�P�Q ,0 keypressedinterminal keyPressedInTerminal( )�O) o      �N�N 0 codekey  �O  �P  ' k     z** +,+ r     -.- I     �M/�L�M 0 realkeyfrom realKeyFrom/ 0�K0 o    �J�J 0 codekey  �K  �L  . o      �I�I 0 codekey  , 121 O   	 343 O   565 I   �H�G�F
�H .miscactvnull��� ��� null�G  �F  6 n    787 4   �E9
�E 
ttab9 m    �D�D 8 4   �C:
�C 
cwin: m    �B�B 4 m   	 
;;�                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��  2 <�A< O    z=>= O   # y?@? k   * xAA BCB l  * *�@�?�>�@  �?  �>  C DED l  * *�=�<�;�=  �<  �;  E FGF l  * *�:HI�:  H F @ display dialog "Je dois jouer la touche " & (codekey as string)   I �JJ �   d i s p l a y   d i a l o g   " J e   d o i s   j o u e r   l a   t o u c h e   "   &   ( c o d e k e y   a s   s t r i n g )G KLK l  * *�9�8�7�9  �8  �7  L MNM Z   * vOP�6QO =  * /RSR n   * -TUT m   + -�5
�5 
pclsU o   * +�4�4 0 codekey  S m   - .�3
�3 
TEXTP k   2 nVV WXW l  2 2�2�1�0�2  �1  �0  X YZY l  2 2�/�.�-�/  �.  �-  Z [�,[ Z   2 n\]�+^\ F   2 K_`_ ?   2 7aba n   2 5cdc 1   3 5�*
�* 
lengd o   2 3�)�) 0 codekey  b m   5 6�(�( ` =  : Iefe c   : Gghg n   : Eiji 7  ; E�'kl
�' 
cha k m   ? A�&�& l m   B D�%�% j o   : ;�$�$ 0 codekey  h m   E F�#
�# 
TEXTf m   G Hmm �nn  C O N T R O L] k   N foo pqp l  N N�"�!� �"  �!  �   q rsr l  N N�tu�  t #  Une combinaison avec control   u �vv :   U n e   c o m b i n a i s o n   a v e c   c o n t r o ls wxw l  N N����  �  �  x yzy r   N X{|{ c   N V}~} n   N T� 4   O T��
� 
cha � m   P S�� 	� o   N O�� 0 codekey  ~ m   T U�
� 
TEXT| o      �� 
0 touche  z ��� I  Y f���
� .prcskprsnull���     ctxt� o   Y Z�� 
0 touche  � ���
� 
faal� J   ] b�� ��� m   ] `�
� eMdsKctl�  �  �  �+  ^ k   i n�� ��� l  i i����  �  �  � ��� l  i i����  �   Un texte normal � entrer   � ��� 2   U n   t e x t e   n o r m a l   �   e n t r e r� ��� l  i i����  �  					   � ��� 
 	 	 	 	 	� ��
� I  i n�	��
�	 .prcskprsnull���     ctxt� o   i j�� 0 codekey  �  �
  �,  �6  Q k   q v�� ��� l  q q����  �  �  � ��� l  q q����  � + % un nombre correspondant � une touche   � ��� J   u n   n o m b r e   c o r r e s p o n d a n t   �   u n e   t o u c h e� ��� l  q q��� �  �  �   � ���� I  q v�����
�� .prcskcodnull���     ****� o   q r���� 0 codekey  ��  ��  N ���� l  w w��������  ��  ��  ��  @ 4   # '���
�� 
prcs� m   % &�� ���  T e r m i n a l> m     ���                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �A  % ��� l     ��������  ��  ��  � ��� i    !��� I      ������� 0 lance_et_analyse_test  � ���� o      ���� 0 f  ��  ��  � k     ��� ��� l     ��������  ��  ��  � ��� r     ��� c     ��� l    ������ 4     ���
�� 
psxf� o    ���� 0 f  ��  ��  � m    ��
�� 
TEXT� o      ���� "0 commandfilepath commandFilePath� ��� l   ������  � 0 *display dialog "Path = " & commandFilePath   � ��� T d i s p l a y   d i a l o g   " P a t h   =   "   &   c o m m a n d F i l e P a t h� ��� l   ��������  ��  ��  � ��� r    ��� I   ����
�� .rdwrread****        ****� 4    ���
�� 
file� o    ���� 0 f  � �����
�� 
as  � m    ��
�� 
utf8��  � o      ���� (0 testdescriptionstr testDescriptionStr� ��� l   ��������  ��  ��  � ��� l   ������  � D > testDescriptionStr contient la description du test � ex�cuter   � ��� |   t e s t D e s c r i p t i o n S t r   c o n t i e n t   l a   d e s c r i p t i o n   d u   t e s t   �   e x � c u t e r� ��� l   ������  � ) # Chaque ligne repr�sente une donn�e   � ��� F   C h a q u e   l i g n e   r e p r � s e n t e   u n e   d o n n � e� ��� l   ������  � ' ! Ligne 1 : la commande � ex�cuter   � ��� B   L i g n e   1   :   l a   c o m m a n d e   �   e x � c u t e r� ��� l   ������  � 1 + Ligne 2 : la s�quence de touche � ex�cuter   � ��� V   L i g n e   2   :   l a   s � q u e n c e   d e   t o u c h e   �   e x � c u t e r� ��� l   ��������  ��  ��  � ��� r    ��� n    ��� 2    ��
�� 
cpar� o    ���� (0 testdescriptionstr testDescriptionStr� o      ����  0 testdescriptor testDescriptor� ��� l     ��������  ��  ��  � ��� r     #��� m     !��
�� 
null� o      ���� 0 commandtotest commandToTest� ��� r   $ (��� J   $ &����  � o      ���� 0 sequencekeys sequenceKeys� ��� l  ) )��������  ��  ��  � ��� l  ) )������  � ) # On r�cup�re la s�quence de touches   � ��� F   O n   r � c u p � r e   l a   s � q u e n c e   d e   t o u c h e s� ��� l  ) )������  � H B chaque touche se trouve sur une ligne, jusqu'au descripteur '---'   � ��� �   c h a q u e   t o u c h e   s e   t r o u v e   s u r   u n e   l i g n e ,   j u s q u ' a u   d e s c r i p t e u r   ' - - - '� ��� l  ) )�� ��      qui met fin � la suite    � .   q u i   m e t   f i n   �   l a   s u i t e�  X   ) ��� k   9 � 	 r   9 >

 c   9 < o   9 :���� 	0 ligne   m   : ;��
�� 
TEXT o      ���� 	0 ligne  	 �� Z   ? ����� ?   ? D n   ? B 1   @ B��
�� 
leng o   ? @���� 	0 ligne   m   B C����   k   G �  r   G J m   G H��
�� boovfals o      ���� 0 fin    V   K � k   Q �   r   Q Y!"! c   Q W#$# l  Q U%����% n   Q U&'& 4  R U��(
�� 
cha ( m   S T������' o   Q R���� 	0 ligne  ��  ��  $ m   U V��
�� 
TEXT" o      ���� 	0 lastc    )��) Z   Z �*+��,* G   Z o-.- G   Z e/0/ =  Z ]121 o   Z [���� 	0 lastc  2 m   [ \33 �44  
0 =  ` c565 o   ` a���� 	0 lastc  6 m   a b77 �88  . =  h m9:9 o   h i���� 	0 lastc  : m   i l;; �<<   + I  r �����=�� 	0 ligne  ��  = ��>��
�� 
to  > c   v �?@? l  v �A����A n   v �BCB 7  w ���DE
�� 
cha D m   { }���� E m   ~ �������C o   v w���� 	0 ligne  ��  ��  @ m   � ���
�� 
TEXT��  ��  , r   � �FGF m   � ���
�� boovtrueG o      ���� 0 fin  ��   o   O P���� 0 fin   H��H Z   � �IJKLI =  � �MNM n   � �OPO 4   � ���Q
�� 
cha Q m   � ����� P o   � ����� 	0 ligne  N m   � �RR �SS  #J l  � ���TU��  T   ne rien faire   U �VV    n e   r i e n   f a i r eK WXW =  � �YZY o   � ����� 0 commandtotest commandToTestZ m   � ���
�� 
nullX [\[ k   � �]] ^_^ l  � ���`a��  ` 8 2 La commande (en premi�re ligne hors commentaires)   a �bb d   L a   c o m m a n d e   ( e n   p r e m i � r e   l i g n e   h o r s   c o m m e n t a i r e s )_ c��c r   � �ded o   � ����� 	0 ligne  e o      ���� 0 commandtotest commandToTest��  \ fgf =  � �hih o   � ����� 	0 ligne  i m   � �jj �kk  - - -g l��l  S   � ���  L r   � �mnm o   � ����� 	0 ligne  n n      opo  ;   � �p o   � ����� 0 sequencekeys sequenceKeys��  ��  ��  ��  �� 	0 ligne   o   , -����  0 testdescriptor testDescriptor qrq l  � ���������  ��  ��  r sts l   � ���uv��  u � �	display dialog "Commande � tester : " & commandToTest	display dialog "S�quence de touches : " & (first item of sequenceKeys)
	   v �ww  	 d i s p l a y   d i a l o g   " C o m m a n d e   �   t e s t e r   :   "   &   c o m m a n d T o T e s t  	 d i s p l a y   d i a l o g   " S � q u e n c e   d e   t o u c h e s   :   "   &   ( f i r s t   i t e m   o f   s e q u e n c e K e y s ) 
 	t xyx l  � ���������  ��  ��  y z{z I   � ���|���� ,0 runcommandinterminal runCommandInTerminal| }��} o   � ����� 0 commandtotest commandToTest��  ��  { ~~ l  � �����~��  �  �~   ��� X   � ���}�� k   � ��� ��� I  � ��|��{
�| .sysodelanull��� ��� nmbr� m   � ��z�z �{  � ��y� I   � ��x��w�x ,0 keypressedinterminal keyPressedInTerminal� ��v� c   � ���� o   � ��u�u 
0 touche  � m   � ��t
�t 
TEXT�v  �w  �y  �} 
0 touche  � o   � ��s�s 0 sequencekeys sequenceKeys� ��� l  � ��r�q�p�r  �q  �p  � ��� I   � ��o�n�m�o 
0 finish  �n  �m  � ��� l  � ��l���l  � 7 1	display dialog "J'ai fini de tester la commande"   � ��� b 	 d i s p l a y   d i a l o g   " J ' a i   f i n i   d e   t e s t e r   l a   c o m m a n d e "� ��k� l  � ��j�i�h�j  �i  �h  �k  � ��� l     �g�f�e�g  �f  �e  � ��� l     �d�c�b�d  �c  �b  � ��� l     �a�`�_�a  �`  �_  � ��� l      �^���^  � q k
	M�thode qui doit s'assurer qu'une fen�tre existe pour les tests et, le cas
	�ch�ant, l'ouvre et la nomme
   � ��� � 
 	 M � t h o d e   q u i   d o i t   s ' a s s u r e r   q u ' u n e   f e n � t r e   e x i s t e   p o u r   l e s   t e s t s   e t ,   l e   c a s 
 	 � c h � a n t ,   l ' o u v r e   e t   l a   n o m m e 
� ��� i   " %��� I      �]�\�[�] 0 make_a_clitest_window  �\  �[  � O     #��� k    "�� ��� I   	�Z�Y�X
�Z .miscactvnull��� ��� null�Y  �X  � ��� I  
 �W��V
�W .coredoscnull��� ��� ctxt� m   
 �� ���   �V  � ��� I   �U��T
�U .sysodelanull��� ��� nmbr� m    �� ?�      �T  � ��S� r    "��� o    �R�R *0 titrefenetreclitest titreFenetreCLITest� n      ��� 1    !�Q
�Q 
titl� 4   �P�
�P 
cwin� m    �O�O �S  � m     ���                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��  � ��� l     �N�M�L�N  �M  �L  � ��� i   & )��� I      �K�J�I�K "0 noclitestwindow noCLITestWindow�J  �I  � k     7�� ��� O     4��� k    3�� ��� I   	�H�G�F
�H .miscactvnull��� ��� null�G  �F  � ��E� X   
 3��D�� Z    .���C�B� =   %��� n    ��� 1    �A
�A 
titl� o    �@�@ 0 win  � o    $�?�? *0 titrefenetreclitest titreFenetreCLITest� L   ( *�� m   ( )�>
�> boovfals�C  �B  �D 0 win  � 2    �=
�= 
cwin�E  � m     ���                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��  � ��<� L   5 7�� m   5 6�;
�; boovtrue�<  � ��� l     �:�9�8�:  �9  �8  � ��7� l     �6�5�4�6  �5  �4  �7       �3� �2����������3  � �1�0�/�.�-�,�+�*�)�(�'�1 *0 titrefenetreclitest titreFenetreCLITest�0 "0 commandfilepath commandFilePath
�/ .aevtodocnull  �    alis�. 
0 finish  �- >0 savecontentofsimulationwindow saveContentOfSimulationWindow�, ,0 runcommandinterminal runCommandInTerminal�+ 0 realkeyfrom realKeyFrom�* ,0 keypressedinterminal keyPressedInTerminal�) 0 lance_et_analyse_test  �( 0 make_a_clitest_window  �' "0 noclitestwindow noCLITestWindow
�2 
null� �& �%�$���#
�& .aevtodocnull  �    alis�% 0 args  �$  � �"�!�" 0 args  �! 0 f  � � ���
�  
kocl
� 
cobj
� .corecnte****       ****� 0 lance_et_analyse_test  �#  �[��l kh *�k+ [OY��� � (������ 
0 finish  �  �  �  � � D @ B�� >0 savecontentofsimulationwindow saveContentOfSimulationWindow
� .coredoscnull��� ��� ctxt� *j+  O� �b  %�%j U� � J������ >0 savecontentofsimulationwindow saveContentOfSimulationWindow�  �  � ���� 0 resultatfile resultatFile� "0 resultatcontent resultatContent� 0 myfile myFile�  \ q������
�	������
� 
cwin
� 
ttab
� 
pcnt
� 
TEXT
� 
psxf
�
 
perm
�	 .rdwropenshor       file
� 
refn
� 
as  
� 
utf8� 
� .rdwrwritnull���     ****
� .rdwrclosnull���     ****� ?�E�O� *�k/�k/ 	*�,�&E�UUO*�/E�O��el E�O����� O�j OP� � ��� ����� ,0 runcommandinterminal runCommandInTerminal� ����� �  ���� 0 command  �   � ������ 0 command  �� 0 isbusy isBusy� ���� ������� ��� ��� ������� ��������� "0 noclitestwindow noCLITestWindow�� 0 make_a_clitest_window  
�� 
cwin
�� 
ttab
�� 
busy
�� 
prcs
�� .miscactvnull��� ��� null
�� 
faal
�� eMdsKctl
�� .prcskprsnull���     ctxt
�� .sysodelanull��� ��� nmbr
�� 
kfil
�� .coredoscnull��� ��� ctxt�� s*j+   
*j+ Y hO� ��k/�k/ *�,E�UUO� '*��/ *j 	UO� ���kvl O�j Y hUO� *j 	O*�k/�k/ �a *l UU� �� ����������� 0 realkeyfrom realKeyFrom�� ����� �  ���� 0 k  ��  � ���� 0 k  �  ��� ������������� }�� $
�� .miscactvnull��� ��� null
�� 
pcls
�� 
ctxt
�� .sysodlogaskr        TEXT�� 6��  �Y ,��  �Y !� *j O�%�%��,%�&�%j UO�� ��'���������� ,0 keypressedinterminal keyPressedInTerminal�� ����� �  ���� 0 codekey  ��  � ������ 0 codekey  �� 
0 touche  � ��;����������������������m�������������� 0 realkeyfrom realKeyFrom
�� 
cwin
�� 
ttab
�� .miscactvnull��� ��� null
�� 
prcs
�� 
pcls
�� 
TEXT
�� 
leng�� 
�� 
cha �� 
�� 
bool�� 	
�� 
faal
�� eMdsKctl
�� .prcskprsnull���     ctxt
�� .prcskcodnull���     ****�� {*�k+  E�O� *�k/�k/ *j UUO� X*��/ P��,�  A��,�	 �[�\[Zk\Z�2�&� �& ��a /�&E�O�a a kvl Y �j Y �j OPUU� ������������� 0 lance_et_analyse_test  �� ����� �  ���� 0 f  ��  � 	�������������������� 0 f  �� (0 testdescriptionstr testDescriptionStr��  0 testdescriptor testDescriptor�� 0 commandtotest commandToTest�� 0 sequencekeys sequenceKeys�� 	0 ligne  �� 0 fin  �� 	0 lastc  �� 
0 touche  � ��������������������������37��;������Rj��������
�� 
psxf
�� 
TEXT
�� 
file
�� 
as  
�� 
utf8
�� .rdwrread****        ****
�� 
cpar
�� 
null
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
leng
�� 
cha 
�� 
bool
�� 
to  ������ 	0 ligne  �� ,0 runcommandinterminal runCommandInTerminal
�� .sysodelanull��� ��� nmbr�� ,0 keypressedinterminal keyPressedInTerminal�� 
0 finish  �� �*�/�&Ec  O*�/��l E�O��-E�O�E�OjvE�O ��[��l 
kh ��&E�O��,j ~fE�O Hh���i/�&E�O�� 
 �� �&
 	�a  �& *a �[�\[Zk\Za 2�&l Y eE�[OY��O��k/a   hY ��  �E�Y �a   Y ��6FY h[OY�oO*�k+ O "�[��l 
kh kj O*��&k+ [OY��O*j+ OP� ������������� 0 make_a_clitest_window  ��  ��  �  � �������������
�� .miscactvnull��� ��� null
�� .coredoscnull��� ��� ctxt
�� .sysodelanull��� ��� nmbr
�� 
cwin
�� 
titl�� $�  *j O�j O�j Ob   *�k/�,FU� ������������� "0 noclitestwindow noCLITestWindow��  ��  � ���� 0 win  � �������������
�� .miscactvnull��� ��� null
�� 
cwin
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
titl�� 8� 1*j O (*�-[��l kh  ��,b     fY h[OY��UOeascr  ��ޭ