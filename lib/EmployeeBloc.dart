import 'dart:async';
import 'Employee.dart';

class EmployeeBloc
{
  List<Employee> _employeeList =[Employee(1, "employee One",10000.0 ),
    Employee(2, "employee Tw0",20000.0 ),

    Employee(3, "employee Three",30000.0 ),
    Employee(4, "employee Four",40000.0 ),
    Employee(5, "employee Five",50000.0 ),
  ];

  final _employeeListStreamController =StreamController<List<Employee>>();

  final _employeeSalaryIncrementController =StreamController<Employee>();

  final _employeeSalaryDecrementController =StreamController<Employee>();


  Stream<List<Employee >> get employeeListStream => _employeeListStreamController.stream;

  StreamSink<List<Employee >> get employeeListSink => _employeeListStreamController.sink;
  StreamSink<Employee > get employeeSalaryIncrement=> _employeeSalaryIncrementController.sink;
  StreamSink<Employee > get employeeSalaryDecrement=> _employeeSalaryDecrementController.sink;

  EmployeeBloc()
  {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee)
  {
   double salary =employee.salary;

   double incrementedSalary = salary *20/100;

   _employeeList[employee.id -1].salary = salary + incrementedSalary;
   employeeListSink.add(_employeeList);
    


  }


  _decrementSalary(Employee employee)
  {
    double salary =employee.salary;

    double decrementedSalary = salary *20/100;

    _employeeList[employee.id -1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }
  void dispose()
  {
    _employeeListStreamController.close();
    _employeeSalaryIncrementController.close();
    _employeeSalaryDecrementController.close();

  }
}
