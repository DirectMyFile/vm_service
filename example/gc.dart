import "package:vm_service/service_io.dart";

main(List<String> args) async {
  var target = new WebSocketVMTarget(args[0]);
  var socketVm = new WebSocketVM(target);
  VM vm = await socketVm.load();
  print("Dart VM Version: ${vm.version}");
  vm.isolates.forEach((Isolate isolate) async {
    ServiceMap stack = await isolate.getStack();
    print("Isolate ${isolate.name}:");
    print("  New Generation: ${isolate.newSpace.collections}");
    print("    Garbage Collections: ${isolate.newSpace.collections}");
    print("    Average Collection Interval: ${isolate.newSpace.averageCollectionPeriodInMillis}ms");
    print("  Old Generation: ${isolate.oldSpace.collections}");
    print("    Garbage Collections: ${isolate.oldSpace.collections}");
    print("    Average Collection Interval: ${isolate.oldSpace.averageCollectionPeriodInMillis}ms");
  });
}
