import pymysql as db
import os
import sys
def user_login():
    global empcode
    empcode=input("Enter Empcode:")
    emppassword=input("Enter Password:")
    conn=db.connect("127.0.0.1","root","","bds")
    cur=conn.cursor()
    qry="""select empname,role
           from employee
           where empcode=%s and emppassword=md5(%s)"""
    cur.execute(qry,(empcode,emppassword))
    res=cur.fetchone()
    if cur.rowcount==1:
        if res[1]=="Admin":
              admin_menu(res[0],res[1],conn,cur)
        elif res[1]=="Manager":
              manager_menu(res[0],res[1],conn,cur)
        elif res[1]=="Developer":
              employee_menu(res[0],res[1],conn,cur)
        elif res[1]=="Tester":
              employee_menu(res[0],res[1],conn,cur)
    else:
              print("invalid username or password")

    cur.close()
    conn.close()


def admin_menu(eid,role,conn,cur):
    cur.close()    
    while True:
        os.system("cls")
        print("Welcome Administrator ",eid)
        print("Main Menu\n1:Manager\n2:Employee\n3:View all Project\n4:View Bug Report\n5:Exit")
        ch=int(input("Enter Your Choice"))
        
        if ch==1:
            while True:
                os.system("cls")
                print("Main Menu\n1:Create Manager\n2:Update Manager\n3:Delete Manager\n4:View All Managers\n5:Exit")
                ch1=int(input("Enter Your Choice"))
                if ch1==1:
                    create_new_manager(conn,cur,role)
                elif ch1==2:
                    update_employee(conn,cur,role)
                elif ch1==3:
                    delete_employee(conn,cur,role)
                elif ch1==4:
                    x="Manager"
                    view_all_employees(conn,cur,x)
                elif ch1==5:
                    break;
                else:
                    print("Wrong Choice")
        elif ch==2:
            etype=int(input("Enter type of employee 1:Developer 2:Tester"))
            if etype==1:
                r="Developer"
            elif etype==2:
                r="Tester"
            else:
                print("wrong choice")
            while True:
                print("Main Menu\n1:Create Employee\n2:Update Employee Record\n3:Delete Employee Record\n4:View All Employees\n5:Back")
                ch1=int(input("Enter Your Choice"))
                if ch1==1:
                    create_new_employee(conn,cur,role)
                elif ch1==2:
                    update_employee(conn,cur,role)
                elif ch1==3:
                    delete_employee(conn,cur,role)
                elif ch1==4:
                    if etype==1:
                      x="Developer"
                    else:
                      x="Tester"
                    view_all_employees(conn,cur,x)
                elif ch1==5:
                    break;
                else:
                    print("Wrong Choice")
        elif ch==3:
            view_project(conn,cur)
        elif ch==4:
            view_bug_report(conn,cur)
        elif ch==5:
            BDS()
        else:
            print("Invalid choice")

def manager_menu(eid,role,conn,cur):
    os.system("cls")
    print("Welcome Manager ",eid)
    while True:
      
        os.system("cls")
        print("Main Menu\n1:Update Profile\n2:Manage Project\n3:Manage Bug\n4:Back")
        ch=int(input("Enter Your Choice"))
        if ch==1:
            update_employee(conn,cur,role)
        elif ch==2:
              while True:
                os.system("cls")
                print("Main Menu\n1:Add project\n2:Update Project\n3:Delete Project\n4:View All Projects\n5:Exit")
                ch1=int(input("Enter Your Choice"))
                if ch1==1:
                    create_new_project(conn,cur)
                elif ch1==2:
                    update_project(conn,cur)
                elif ch1==3:
                    delete_project(conn,cur)
                elif ch1==4:
                    view_project(conn,cur)
                elif ch1==5:
                    break;
                else:
                    print("Wrong Choice")
        
        elif ch==3:
             while True:
                os.system("cls")
                print("Main Menu\n1:Add bug\n2:Update bug\n3:Delete bug\n4:View All bugs\n5:Exit")
                ch1=int(input("Enter Your Choice"))
                if ch1==1:
                    create_new_bug(conn,cur)
                elif ch1==2:
                    update_bug(conn,cur)
                elif ch1==3:
                    delete_bug(conn,cur)
                elif ch1==4:
                    view_all_bugs(conn,cur)
                elif ch1==5:
                    break;
                else:
                    print("Wrong Choice")
        elif ch==4:
            BDS()
        else:
            print("Invalid choice")

def employee_menu(eid,role,conn,cur):
    os.system("cls")
    if(role=='Developer'):
        print("Welcome Developer ",eid,"\n\n")
    else:
        print("Welcome tester ",eid,"\n\n")
    while True:
        print("Main Menu\n1:Update Profile\n2:add bug report\n3:update bug status\n4:view bugs\n5:bug details\n6:Exit")
        ch=int(input("Enter Your Choice"))
        if ch==1:
            update_employee(conn,cur,role)
        elif ch==2:
            add_bug_report(conn,cur)
        elif ch==3:
            update_bug_status(conn,cur)
        elif ch==4:
            view_all_bugs(conn,cur)
        elif ch==5:
            bug_details(conn,cur)         
        elif ch==6:
            BDS()
        else:
            print("Invalid choice")

def create_new_employee(conn,cur,role):
    if role=="Admin" or "Manager":
    
      empcode=input("Enter Employee id")
      empname=input("Enter Name")
      empemail=input("Enter Email")
      emppassword=input("Enter Password")
      gender=input("Enter Gender")
      dob=input("Enter dob")
      mobileno=input("Enter mobileno")
      post=input("Enter role")
      
      cur=conn.cursor()
      qry="""insert into employee
             values(%s,%s,%s,md5(%s),%s,%s,%s,%s)"""
      if(cur.execute(qry,(empcode,empname,empemail,emppassword,gender,dob,mobileno,post))):
          conn.commit()
          print("Employee created")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0
    else:
      print("You are not eligible to do this!")
      return 0

def update_employee(conn,cur,role):
    emp_code=input("Enter Employee id to be updated")
    empname=input("Enter Name")
    empemail=input("Enter Email")
    emppassword=input("Enter Password")
    gender=input("Enter Gender")
    dob=input("Enter dob")
    mobileno=input("Enter mobileno")
    post=input("enter role")
    cur=conn.cursor()
    qry="""update employee set empname=%s,empemail=%s,emppassword=md5(%s),gender=%s,dob=%s,mobileno=%s,role=%s
           where empcode=%s"""
    if(cur.execute(qry,(empname,empemail,emppassword,gender,dob,mobileno,post,emp_code))):
        if role=="Admin":
          conn.commit()
          print("Employee updated")
          cur.close()
          return 1
        elif role=="Manager":
          if post=="Manager" or "Developer" or "Tester":
            conn.commit()
            print("Employee updated")
            cur.close()
            return 1
          else:
            print("You are not eligible to do this!")
        elif role=="Tester" or "Developer":
           
           if empcode==emp_code:
             conn.commit()
             print("Employee updated")
             cur.close()
             return 1
           else:
             print("you are not elligible to do this")
             cur.close()
             return 1
        else:
              print("some error")
              cur.close()
              return 0

def delete_employee(conn,cur,role):
    empcode=input("Enter Employee id")
    cur=conn.cursor()
    qry="""delete from employee
           where empcode=%s"""
    if(cur.execute(qry,(empcode,))):
        conn.commit()
        print("Employee deleted")
        cur.close()
        return 1
    else:
        print("some error")
        cur.close()
        return 0


def view_all_employees(conn,cur,x):
    cur=conn.cursor()
    qry="""select empcode,empname,empemail,gender,dob,mobileno,role
           from employee where role=%s"""
    cur.execute(qry,x)
    if(cur.rowcount>0):
        ds=cur.fetchall()
        for row in ds:
            for val in row:
                print(val,end="\t")
            print()
    else:
        print("\nNo record found")
    cur.close()
    os.system("pause")
    return 0


def view_project(conn,cur):
    cur=conn.cursor()
    qry="""select * from project"""
    cur.execute(qry)
    if(cur.rowcount>0):
        ds=cur.fetchall()
        for row in ds:
            for val in row:
                print(val,end="\t")
            print()
    else:
        print("\nNo record found")
    cur.close()
    os.system("pause")
    return 0


def view_bug_report(conn,cur):
    cur=conn.cursor()
    qry="""select * from bugreport"""
    cur.execute(qry)
    if(cur.rowcount>0):
        ds=cur.fetchall()
        for row in ds:
            for val in row:
                print(val,end="\t")
            print()
    else:
        print("\nNo record found")
    cur.close()
    os.system("pause")
    return 0

def create_new_project(conn,cur):
    
      pro_id=input("Enter Project id")
      pro_name=input("Enter Project Name")
      st_date=input("Enter Start Date")
      end_date=input("Enter End Date")
      pro_desc=input("Enter Project description")
      
      cur=conn.cursor()
      qry="""insert into project
             values(%s,%s,%s,%s,%s)"""
      if(cur.execute(qry,(pro_id,pro_name,st_date,end_date,pro_desc))):
          conn.commit()
          print("New Project created!")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0
def update_project(conn,cur):
  pro_id=input("Enter Project id which you want to update")
  pro_name=input("Enter Project Name")
  st_date=input("Enter Start Date")
  end_date=input("Enter End Date")
  pro_desc=input("Enter Project description")

  cur=conn.cursor()
  qry="""update project set projectName=%s,sdate=%s,edate=%s,projectdesc=%s
         where projectId=%s"""
  if(cur.execute(qry,(pro_name,st_date,end_date,pro_desc,pro_id))):
      conn.commit()
      print("Project updated!")
      cur.close()
      return 1
  else:
      print("some error")
      cur.close()
      return 0

def delete_project(conn,cur):
   pro_id=input("Enter Project id which you want to delete")
   cur=conn.cursor()
   qry="""delete from project where projectId=%s"""
   if(cur.execute(qry,(pro_id,))):
        conn.commit()
        print("Project Deleted!")
        cur.close()
        return 1
   else:
        print("some error")
        cur.close()
        return 0

def create_new_bug(conn,cur):
      bug_code=input("Enter bug code")
      bug_category=input("Enter bug category")
      bug_severty=input("Enter bug severty")
      
      cur=conn.cursor()
      qry="""insert into bugtype
             values(%s,%s,%s)"""
      if(cur.execute(qry,(bug_code,bug_category,bug_severty))):
          conn.commit()
          print("New Bug created!")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0

def update_bug(conn,cur):
      bug_code=input("Enter bug code you want to update")
      bug_category=input("Enter updated bug category")
      bug_severty=input("Enter updated bug severty")
      
      cur=conn.cursor()
      qry="""update bugtype set bugcategory=%s,bugseverty=%s where bugcode=%s"""
      if(cur.execute(qry,(bug_category,bug_severty,bug_code))):
          conn.commit()
          print(" Bug Updated!")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0
  
def delete_bug(conn,cur):
      bug_code=input("Enter bug code to be deleted")
      
      cur=conn.cursor()
      qry="""delete from bugtype where bugcode=%s"""
      if(cur.execute(qry,(bug_code,))):
          conn.commit()
          print("Bug Deleted")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0

def view_all_bugs(conn,cur):
      cur=conn.cursor()
      qry="""select * from bugtype"""
      if(cur.execute(qry)):
        if(cur.rowcount>0):
          ds=cur.fetchall()
          for row in ds:
              for val in row:
                  print(val,end="\t")
              print()

          conn.commit()
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0
def add_bug_report(conn,cur):
      bug_no=input("Enter bug no.")
      bug_code=input("Enter bug code")
      pro_id=input("Enter project id")
      emp_code=input("Enter employee code")
      status=input("Enter bug status")
      bug_desc=input("Enter bug description")
      
      cur=conn.cursor()
      qry="""insert into bugreport
             values(%s,%s,%s,%s,%s,%s)"""
      if(cur.execute(qry,(bug_no,bug_code,pro_id,emp_code,status,bug_desc))):
          conn.commit()
          print("New Bug Report created!")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0


def update_bug_status(conn,cur):
      bug_no=input("Enter bug no. whose bug report has to be updated")
      bug_code=input("Enter bug code")
      pro_id=input("Enter project id")
      emp_code=input("Enter employee code")
      status=input("Enter bug status")
      bug_desc=input("Enter bug description")
      
      cur=conn.cursor()
      qry="""update  bugreport set bugcode=%s,projectid=%s,empcode=%s,status=%s,bugdesc=%s where bugno=%s"""
      if(cur.execute(qry,(bug_code,pro_id,emp_code,status,bug_desc,bug_no))):
          conn.commit()
          print("Bug Report updated!")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0


def bug_details(conn,cur):
      bug_no=input("Enter bug no.")
      
      cur=conn.cursor()
      qry="""select * from bugreport where bugno=%s"""
      if(cur.execute(qry,(bug_no,))):
          det=cur.fetchone()
          print(det)
          conn.commit()
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0
def create_new_manager(conn,cur,role):
    if role=="Admin" or "Manager":
    
      empcode=input("Enter Employee id")
      empname=input("Enter Name")
      empemail=input("Enter Email")
      emppassword=input("Enter Password")
      gender=input("Enter Gender")
      dob=input("Enter dob")
      mobileno=input("Enter mobileno")
      post="Manager"
      cur=conn.cursor()
      qry="""insert into employee
             values(%s,%s,%s,md5(%s),%s,%s,%s,%s)"""
      if(cur.execute(qry,(empcode,empname,empemail,emppassword,gender,dob,mobileno,post))):
          conn.commit()
          print("Employee created")
          cur.close()
          return 1
      else:
          print("some error")
          cur.close()
          return 0
    else:
      print("You are not eligible to do this!")
      return 0        



def BDS():
    print("WELCOME TO BUG TRAKING SYSTEM AND ANALYSIS")
    print("1 LOGIN\n2 EXIT")
    ch=int(input("Enter choice"))
    if(ch==1):
        user_login()
    else:
        print("see you later")
        sys.exit()

if __name__=="__main__":
    BDS()
    
           
