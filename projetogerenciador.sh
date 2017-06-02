#!/bin/bash

#Projeto de gerenciamento de arquivos,usuários,rede,dispositivos e pacotes.

#-----------------------------------------------------------------------------------
#-------------- INICIO DO CÓDIGO DE GERENCIAMENTO DE ARQUIVOS/DIRETÓRIOS -----------
#---------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------ SUB MENU ARQUIVOS / DIRETORIOS -------------------------

GARQ(){
OPCAO=$(dialog								\
		--stdout						\
		--title 'Gerenciamento de Arquivos e Diretórios'	\
		--menu	'Escolha uma opção:'				\
		0 0 0							\
		1 'Criar arquvivo'					\
		2 'Apagar arquivo' 					\
		3 'Renomear arquivo'					\
		4 'Mover arquivo'					\
		5 'Listar arquivos / diretórios'			\
		6 'Criar diretório' 					\
		7 'Apagar diretório'					\
		8 'Renomear diretório'				        \
		9 'Mover diretório'					\
		10 'Voltar')

case $OPCAO in
	1) CARQ ;;
	2) AARQ ;;
	3) RARQ ;;
	4) MARQ ;;
	5) LAED ;;
	6) CDIR ;;
	7) ADIR ;;
	8) RDIR ;;
	9) MDIR ;;
	10) MENU ;;
	*) MENU ;;
esac
}

#---------------------------------------------------------------------------------
#----------------------- CRIAR ARQUIVOS -------------------------------------------

CARQ(){

CRIA=$(dialog	--stdout --title 'Criar novo arquivo'				\
		--inputbox 'Digite o nome do arquivo: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local para salvar:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac


if [ -e "$LOCAL$CRIA" ]; then

               (dialog --title 'Atenção!'					\
		      --msgbox 'Esse arquivo já existe nesse diretório.'	\
		      0 0)
else

	> $LOCAL$CRIA
	      (dialog --title 'Parabéns!'					\
		      --msgbox 'Arquivo criado com sucesso.' 			\
		      0 0)
 
fi

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------------ APAGAR ARQUIVOS ----------------------------------

AARQ(){

APAGA=$(dialog	--stdout --title 'Apagar arquivo'				\
		--inputbox 'Digite o nome do arquivo: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local do arquivo:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

rm $LOCAL$APAGA 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Arquivo deletado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}


#----------------------------------------------------------------------------
#------------------------ RENOMEAR ARQUIVOS ---------------------------

RARQ(){

LOCAL=$(dialog	--stdout --title 'Selecione o local onde está o arquivo:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOME=$(dialog	--stdout --title 'Renomear arquivo'				\
		--inputbox 'Digite o nome do arquivo: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOVONOME=$(dialog --stdout --title 'Renomear arquivo'				\
		  --inputbox 'Digite o novo nome do arquivo: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

mv $NOME $NOVONOME 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Arquivo renomeado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------ MOVER ARQUIVOS----------------------------------------

MARQ(){
MOVER=$(dialog	--stdout --title 'Selecionar o arquivo'				\
		--inputbox 'Digite o nome do arquivo: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local para mover o arquivo:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

if [ -z $MOVER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	MARQ

else

mv $MOVER $LOCAL 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Arquivo movido com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GARQ
}


#-----------------------------------------------------------------------------------
#--------------------- LISTAR ARQUIVOS E DIRETÓRIOS --------------------------------

LAED(){

LIST=$(dialog	--stdout --title 'Selecione o local que deseja listar:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

ls -la $LIST > /tmp/lista
	       (dialog --textbox /tmp/lista 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

GARQ
}


#-----------------------------------------------------------------------------------
#--------------------- CRIAR DIRETORIOS--------------------------------------------

CDIR(){

CRIADIR=$(dialog --stdout --title 'Criar novo diretório'			\
		 --inputbox 'Digite o nome do diretório: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog --stdout --title 'Selecione o local para salvar:'		\
		 --fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac


mkdir $LOCAL$CRIADIR 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório criado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------------ APAGAR DIRETÓRIOS ----------------------------------

ADIR(){

APAGADIR=$(dialog --stdout --title 'Apagar diretório'				\
		  --inputbox 'Digite o nome do diretório:'	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local do diretório:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

rmdir $LOCAL$APAGADIR 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório deletado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------ RENOMEAR DIRETÓRIOS ---------------------------

RDIR(){

LOCAL=$(dialog	--stdout --title 'Selecione o local onde está o diretório:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOME=$(dialog	--stdout --title 'Renomear diretório'				\
		--inputbox 'Digite o nome do diretório: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOVONOME=$(dialog --stdout --title 'Renomear diretório'				\
		  --inputbox 'Digite o novo nome do diretório: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

mv $NOME $NOVONOME 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório renomeado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------ MOVER DIRETÓRIOS ----------------------------------------

MDIR(){

MOVER=$(dialog	--stdout --title 'Selecionar o diretório'			\
		--inputbox 'Digite o nome do diretório: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local para mover o diretório:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

if [ -z $MOVER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	MARQ

else

mv $MOVER $LOCAL 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório movido com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GARQ
}

#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
#-------------- FIM DO CÓDIGO DE GERENCIAMENTO DE ARQUIVOS/DIRETÓRIOS ---------------
#-----------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------
#----------------- INICIO DO CÓDIGO DE GERENCIAMENTO DE USUÁRIOS/GRUPOS -------------
#----------------------------------------------------------------------------------
#----------------------------------------------------------------------------------
#------------------- SUB MENU USUÁRIO-----------------------------------------------

GUSR() {
USER=$(dialog							\
	--stdout						\
        --title 'Gerenciamento de Usuários e Grupos'            \
        --menu 'Escolha uma opção:' 0 0 0			\
	1 'Criar usuário'					\
	2 'Deletar usuário'					\
	3 'Alterar a senha do usuário'                          \
	4 'Listar usuários do sistema'				\
	5 'Criar grupo'						\
	6 'Deletar grupo'					\
	7 'Listar grupos do sistema'				\
	8 'Adicionar usuário a um grupo'			\
	9 'Remover usuário de um grupo'				\
	10 'Voltar')						\
	
case $USER in
	1) CUSR ;;
	2) DUSR ;;
	3) PUSR ;;
	4) LUSR ;;
	5) CGRU ;;
	6) DGRU ;;
	7) LGRU ;;
	8) AGRU ;;
	9) RGRU ;;
	10) MENU ;;
	*) dialog ; MENU ;;
esac
} 

#-----------------------------------------------------------------------------------
#----------------------------- CRIAR USUÁRIO-----------------------------------------

CUSR(){

NUSER=$(dialog  						\
		--stdout --title 'Criar novo usuário'		\
		--inputbox 'Digite o nome do usuário:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $NUSER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	CUSR

else

useradd $NUSER 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Usuário criado com sucesso.' 		\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GUSR

}

#-----------------------------------------------------------------------------------
#------------------DELETAR USUÁRIO-----------------------------------------

DUSR(){
DUSER=$(dialog  						\
		--stdout --title 'Deletar usuário'		\
		--inputbox 'Digite o nome do usuário:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $DUSER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	CUSR

else

userdel $DUSER 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Usuário deletado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
fi

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ALTERAR A SENHA DO USUÁRIO-----------------------------------------

PUSR(){
USR=$(dialog  						        \
		--stdout --title 'Alterar a senha do usuário'	\
		--inputbox 'Digite o nome do usuário:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

PASS=$(dialog							\
               	--stdout --title 'Alterar a senha do usuário'	\
		--passwordbox 'Digite a senha:'		        \
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

PASS2=$(dialog							\
               	--stdout --title 'Alterar a senha do usuário'	\
		--passwordbox 'Digite a senha novamente:'	\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac
         
if [ -z $PASS ] || [ -z $PASS2 ] || [ -z $USR ]; then
    
	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	PUSR
   
else

(echo $PASS ; echo $PASS2) | passwd $USR 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog							\
		--title 'Parabéns!' 					\
		--msgbox 'Senha alterada com sucesso.'  	 	\
		0 0 || dialog --title 'Atenção'				\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
    
fi 

GUSR
}

#-----------------------------------------------------------------------------------
#------------------LISTAR USUÁRIOS DO SISTEMA-----------------------------------------

LUSR(){
        tail -f /etc/passwd > out &
	dialog							\
		--title 'Listando todos os usuários'		\
		--tailbox out					\
		0 0
GUSR
}

#-----------------------------------------------------------------------------------
#------------------ CRIAR GRUPO-----------------------------------------

CGRU(){

NGRUP=$(dialog  						\
		--stdout --title 'Criar novo grupo'		\
		--inputbox 'Digite o nome do grupo:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $NGRUP ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	CGRU

else

groupadd $NGRUP 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Grupo criado com sucesso.' 		\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ DELETAR GRUPO-----------------------------------------

DGRU(){

DGRUP=$(dialog  						\
		--stdout --title 'Deletar grupo'		\
		--inputbox 'Digite o nome do grupo:'		\
		0 0)
case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $DGRUP ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	DGRU

else

groupdel $DGRUP 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Grupo deletado com sucesso.' 	 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
fi

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ LISTAR GRUPOS DO SISTEMA-----------------------------------------

LGRU(){
        tail -f /etc/group > out &
	dialog							\
		--title 'Listando todos os grupos'		\
		--tailbox out					\
		0 0
GUSR
}

#-----------------------------------------------------------------------------------
#------------------ ADICIONAR USUÁRIO A UM GRUPO---------------------------------------

AGRU(){    
USR=$(dialog							        \
		--stdout						\
		--title 'Adicionar usuário'				\
		--inputbox 'Digite o nome do usuário:'		        \
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

GRU=$(dialog								\
		--stdout						\
		--title 'Selecionar grupo'				\
		--inputbox 'Digite o nome do grupo:'			\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $USR ] || [ -z $GRU ]; then
    
	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	AGRU
   
else

gpasswd -a $USR $GRU 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog							\
		--title 'Parabéns!' 					\
		--msgbox 'Usuário adicionado com sucesso.'  	 	\
		0 0 || dialog --title 'Atenção'				\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
    
fi 

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ REMOVER USUÁRIO DE UM GRUPO---------------------------------------

RGRU(){
USR=$(dialog							        \
		--stdout						\
		--title 'Remover usuário'				\
		--inputbox 'Digite o nome do usuário:'		        \
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

GRU=$(dialog								\
		--stdout						\
		--title 'Selecionar grupo'				\
		--inputbox 'Digite o nome do grupo:'			\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $USR ] || [ -z $GRU ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	RGRU

else

gpasswd -d $USR $GRU 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog							\
		--title 'Parabéns!' 					\
		--msgbox 'Usuário removido com sucesso.'   	 	\
		   0 0 || dialog --title 'Atenção'			\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
  
fi

GUSR
}

#-----------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
#----------------- FIM DO CÓDIGO DE GERENCIAMENTO DE USUÁRIOS ------------------
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#----------------- INICIO DO CÓDIGO DE GERENCIAMENTO DE REDE ------------------
#---------------------------------------------------------------------------------

GRED(){
OPCAO=$(dialog						\
	--stdout					\
	--title 'Gerenciamento de Rede'			\
	--menu 'Escolha uma opção:'			\
	0 0 0						\
	1 "Configurar Rede"				\
	2 "Configurar o nome da máquina"		\
	3 "Voltar")

case $OPCAO in
	1) CREDE ;;
	2) CHOST ;;
	3) MENU ;;
	*) dialog ; MENU ;;

esac

GRED

}

#---------------------------------------------------------------------------------
#---------------------- CONFIGURAR REDE ------------------------------------------

CREDE(){

address=$(dialog --stdout --title 'Endereço IP' 			\
		  --inputbox 'Digite o IP:'				\
		  0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

netmask=$(dialog --stdout --title 'Máscara de Rede' 			\
		  --inputbox 'Digite a máscara de Rede:'		\
		  0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

gateway=$(dialog --stdout --title 'Gateway'	 			\
		  --inputbox 'Digite o IP do Gateway:'			\
		  0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac


echo "
	# The loopback network interface
	auto lo
        iface lo inet loopback

	# Interface de Rede 1
	auto eth1
	iface eth1 inet static
	address $address
	netmask $netmask
	gateway $gateway " > /etc/network/interfaces
	
	/etc/init.d/networking.restart 	

	MENU

}


#---------------------------------------------------------------------------------
#-------------------- CONFIGURAR HOSTNAME -----------------------------------------

CHOST(){
NOME=$(dialog --stdout --title 'Alterar o nome da máquina'		\
	      --inputbox 'Digite um nome:'				\
		  0 0)
case $? in 1) GUSR ;; 255) GUSR ;; esac

if [-z $NOME ]; then

      (dialog --stdout --title 'Atenção'				\
	      --inputbox 'Nome inválido. Tente novamente.'		\
		  0 0)

else

	> /etc/hostname/$NOME

	 (dialog --stdout --title 'Parabés!'				\
	      --msgbox '\nRenomeado com sucesso. Reinicie a máquina para aplicar as alterações.'		\
		0 0)

fi

GREDE

}

#---------------------------------------------------------------------------------
#----------------- FIM DO CÓDIGO DE GERENCIAMENTO DE REDE ------------------
#---------------------------------------------------------------------------------
	
#---------------------------------------------------------------------------------
#----------------- INICIO DO CÓDIGO DE GERENCIAMENTO DE PACOTES ------------------
#---------------------------------------------------------------------------------
#------------------------SUB MENU PACOTES----------------------------------------

GPAC(){
OPCAO=$(dialog						\
	--stdout					\
	--title " Gerenciamento de Pacotes "		\
	--menu 'Escolha uma opção:'			\
	0 0 0						\
	1 "Instalar Pacote"				\
	2 "Remover Pacote"				\
	3 "Listar Pacotes"				\
	4 "Atualizar pacotes"				\
	5 "Voltar")

case $OPCAO in
	1) IPAC ;;
	2) RPAC ;;
	3) LPAC ;;
	4) APAC ;;
	5) MENU ;;
	*) dialog ; MENU ;;
	
esac

GPAC
}


#---------------------------------------------------------
#-------------------- INSTALAR PACOTE---------------------

IPAC(){
INSTA=$( dialog						\
	--stdout					\
	--title " Instalação de pacote "		\
	--inputbox " Qual pacote deseja instalar? "	\
	0 0)
case $? in 1) GPAC ;; 255) GPAC ;; esac
IPAC2
}

IPAC2(){
	dialog						\
	--title " Instalando... "			\
	--infobox " Aguarde... "			\
	0 0
case $? in 1) GPAC ;; 255) GPAC ;; esac

	apt-get install $INSTA &> /dev/null 
	IPAC3

}

IPAC3(){
	dialog						\
	--title " Parabéns! "				\
	--msgbox "$INSTA Instalado com sucesso"		\
	0 0
	GPAC
}

#--------------------------------------------------------
#---------------------REMOVER PACOTE---------------------

RPAC(){
REM=$(dialog						\
	--stdout					\
	--title " Removendo Pacote "			\
	--inputbox "Qual pacote deseja remover?"	\
	0 0)
case $? in 1) GPAC ;; 255) GPAC ;; esac
REM2
}

REM2(){
	dialog						\
	--stdout					\
	--title " Removendo... "			\
	--infobox " Aguarde um instante... "		\
	0 0
case $? in 1) GPAC ;; 255) GPAC ;; esac

	apt-get remove $REM &> /dev/null 		\
	sleep 2
	REM3
}

REM3(){
	apt-get purge -y $REM &> /dev/null
	sleep 2
	REM4
}

REM4(){
	dialog						\
	--title " Parabéns! "				\
	--msgbox "$REM Removido com sucesso!"		\
	0 0
	GPAC

}

#--------------------------------------------------------
#----------------------LISTA PACOTE----------------------

LPAC(){
	apt list --installed > /tmp/aptlist.txt
	cat -n /tmp/aptlist.txt > /tmp/aptlist2.txt
	dialog						\
	--textbox /tmp/aptlist2.txt			\
	20  70
case $? in 1) GPAC ;; 255) GPAC ;; esac
GPAC
}

#-------------------------------------------------------
#---------------------ATUALIZAR PACOTE------------------

APAC(){
ATU=$(dialog --stdout					\
	--title " Atualizar Pacotes "			\
	--yesno "Atualizar pacotes do sistema:"		\
	0 0)
case $? in 1) GPAC ;; 255) GPAC ;; esac

ATU=$?
if [ $? == 0 ]; then

dialog 	--infobox "Aguarde um instante..." 0 0

apt-get update &> /dev/null

case $? in 1) GPAC ;; 255) GPAC ;; esac
	dialog						\
	--infobox "Atualizados com sucesso!"		\
	0 0
	sleep 2
	GPAC
else
GPAC
fi
}

#-------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
#----------------- FIM DO CÓDIGO DE GERENCIAMENTO DE PACOTES ------------------
#---------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
#----------------- INICIO DO CÓDIGO DE INFO. DO SISTEMA -------------------------
#---------------------------------------------------------------------------------
#---------------------------- SUB MENU INFO. DO SISTEMA --------------------------
#-------------------------------------------------------------------------------

INFO(){
OPCAO=$(dialog							\
		--stdout					\
		--title 'Informações do sistema'		\
		--menu 'Escolha uma opção: '			\
		0 0 0						\
		1 'Calendário'					\
		2 'Horário'					\
		3 'Desenvolvedores'				\
		4 'Versão do Software'				\
		5 'Voltar')

case $OPCAO in
	1) CALE ;;
	2) HORA ;;
	3) DEVS ;;
	4) VER ;;
	5) MENU ;;
	*) MENU ;;
esac
}

#-------------------------------------------------------------------------------
#---------------------------- CALENDÁRIO --------------------------

CALE(){
	(dialog	--title 'Calendário' --calendar ' ' 0 0)	\

case $? in 1) INFO ;; 255) INFO ;; esac	

INFO	
}

#-------------------------------------------------------------------------------
#--------------------------- HORÁRIO ------------------------------------------

HORA(){
	(dialog	--title 'Ajuste o Relógio' 			\
		--timebox '\nDICA: Use as setas e o TAB' 0 0)		

case $? in 1) INFO ;; 255) INFO ;; esac	

INFO	
}

#--------------------------------------------------------------------------
#------------------------ DESENVOLVEDORES -------------------------

DEVS(){	(dialog							\
	--title 'Desenvolvedores' 				\
	--msgbox '\nFrancisco Tadeu
		    Fernanda 
		    Gabriel Alejandro 
		    Heitor Aparicio' \
		0 0)		

case $? in 1) INFO ;; 255) INFO ;; esac	

INFO	
}

#--------------------------------------------------------------------------
#------------------------ VERSÃO -------------------------

VER(){	(dialog --title 'Versão' --msgbox '\nVERSÃO DO SOFTWARE: 1.0' \
		0 0)		

case $? in 1) INFO ;; 255) INFO ;; esac	

INFO	
}

#-------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
#----------------- FIM DO CÓDIGO DE INFO. DO SISTEMA -------------------------
#---------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#---------------------MENU PRINCIPAL--------------------------------------------
#-------------------------------------------------------------------------------

MENU(){
OPCAO=$(dialog						\
	--stdout --title 'MENU'				\
	--menu 'Escolha uma opção:'			\
	0 0 0						\
	1 'Gerenciar Arquivos / Diretórios'		\
	2 'Gerenciar Usuarios / Grupos'			\
	3 'Gerenciar Rede'				\
	4 'Gerenciar Pacotes'				\
	5 'Informações do sistema'			\
	6 'Sair do programa')

case $OPCAO in
	1) GARQ ;;
	2) GUSR ;;
	3) GRED ;;
	4) GPAC ;;
	5) INFO ;;
	6) FIM	;;
	*) FIM ;;
esac
}

#-------------------------------------------------------------------------------
#------------------------ FIM DO MENU PRINCIPAL --------------------------------
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#---------------------- FIM DO PROGRAMA------------------------------------------

FIM(){ (dialog								\
	--stdout --title 'Finalizado'					\
	--msgbox 'Até breve. Volte sempre!' 	   			\
	  0 0)
	exit 0
}

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#-------------------------- USUARIO E SENHA / TELA INICIAL--------------------

USER=""
PASS=""
USUARIO=$(dialog							\
		--stdout						\
		--title 'Usuário'					\
		--inputbox 'Digite o nome do seu usuário: '		\
		0 0)

case $? in 1) FIM ;; 255) FIM ;; esac

SENHA=$(dialog								\
		--stdout						\
		--title 'Senha'						\
		--passwordbox ' Digite a sua senha: '			\
		0 0)
case $? in 1) FIM ;; 255) FIM ;; esac

[ $USUARIO == $USER ] && [ $SENHA == $PASS ] && MENU || FIM
#------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
