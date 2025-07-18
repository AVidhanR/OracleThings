The below are the different types of OCI Compute:

## Virtual Machines (VMs)
Share a physical server with others; highly flexible and cost-effective for general use. **What it is:** Imagine you have a very powerful physical computer, and inside it, you create several "mini-computers" that act like completely separate machines. Each mini-computer (VM) has its own operating system (like Windows or Linux) and can run its own applications, but they all share the resources (CPU, memory, storage) of the single physical computer. This sharing is managed by special software called a "hypervisor."

## Bare Metal
Get an entire physical server just for yourself; maximum performance and control. **What it is:** Instead of sharing a powerful computer with others, you get exclusive access to an entire physical server. There's no "hypervisor" layer between your applications and the hardware (unless you choose to install one yourself). It's like having your own dedicated computer in the cloud

## Dedicated Hosts
Get a physical server just for yourself, but then you run your own VMs on it; combines isolation with VM flexibility. **What it is:** This is a blend of VMs and Bare Metal. You get a physical server that is dedicated to you (like Bare Metal), but on that specific server, you can then run multiple Virtual Machines that are all yours. So, while the physical server is exclusively for you, you still benefit from the flexibility of running multiple VMs on it.
