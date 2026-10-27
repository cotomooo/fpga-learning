# fpga-learning

正点原子 **ATK-L50**（紫光同创 **PGL50G**）开发板上的 FPGA 学习练习记录，按 **P0–P3** 阶段整理，对应《【正点原子】ATK-L50 开发板之 FPGA 开发指南》**第 1–24 章**。

每个练习都按同一套流程完成：

> 先自己画波形 / 推真值表 / 想清数据流 → 自己写 RTL → 写轻量自检 TB → 综合 · 管脚约束 · 上板 → 最后才对照指南的参考代码

## 板卡与工具链

| 项目 | 内容 |
|---|---|
| 开发板 | 正点原子 ATK-L50（底板 + 核心板） |
| FPGA | 紫光同创 Logos **PGL50G-6MBG324** |
| 综合 / 实现 | Pango Design Suite (PDS) **2022.2-SP4.2** |
| 仿真 | ModelSim SE-64 **2020.4** |
| 板载系统时钟 | 50 MHz |
| 参考教程 | 《【正点原子】ATK-L50 开发板之 FPGA 开发指南》V1.0 |

## 目录结构

```text
.
├── README.md
├── .gitignore
├── p0-led/                 # 第 1–6 章：工具链与完整开发流程
│   ├── led/
│   └── led_repeat/
├── p1-basics/              # 第 7–15 章：数电基础与组合 / 时序逻辑
│   ├── gate/               #   与门 / 或门 / 非门 / 三合一
│   ├── mux2_1/  decoder3_8/
│   ├── shift_reg/  counter/  counter_1s/
│   ├── edge_test/
│   └── divider_4/  divider_7/
├── p2-peripherals/         # 第 16–20 章：板级外设
│   ├── flow_led/  flow_led_250ms/
│   ├── key_led/  touch_led/  beep/  two_key_beep/
│   └── breath_led/
└── p3-ip/                  # 第 21–24 章：IP 核
    ├── ip_pll/
    ├── ip_1port_ram/  ip_2port_ram/
    └── ip_fifo/
```

每个练习内部：

```text
<练习>/
├── rtl/          # Verilog 源码
├── sim/tb/       # 轻量自检 testbench（定向激励 + 末尾 PASS/FAIL）
├── prj/          # PDS 工程（.pds）与引脚 / 时钟约束（.fdc）
└── doc/          # 个别练习附带的框图（仅 led）
```

> 说明：`prj/ipcore/` 仅 P3 存在，保存 IP 核配置（`.idf`）与生成文件；构建产物（位流、布线 / 时序数据库、日志、ModelSim `work/` 库等）不进仓库。

## 练习索引

图例：**✅ 完整工程** = RTL + 自检 TB + PDS 工程 + 引脚约束，本机已生成位流；**🧪 仅仿真** = RTL + 自检 TB，未保留完整 PDS 工程；**📄 工程待补** = PDS 工程缺少约束 / 位流。

### P0 · 工具链与完整开发流程（第 1–6 章）

| 练习 | 指南 | 内容 | 自检 TB | 状态 |
|---|---|---|---|---|
| `p0-led/led` | 第 5 章 | 点亮 LED：建工程 → 综合 → 实现 → 约束 → 下载 → 固化 | ✅ | ✅ 完整工程 |
| `p0-led/led_repeat` | 第 5 章 | 同上的第二遍：脱离指南独立复现全流程 | ✅ | ✅ 完整工程 |

### P1 · 数电基础与组合 / 时序逻辑（第 7–15 章）

| 练习 | 指南 | 内容 | 自检 TB | 状态 |
|---|---|---|---|---|
| `p1-basics/gate/and_gate` | 第 8 章 | 与门 | ✅ | ✅ 完整工程 |
| `p1-basics/gate/or_gate` | 第 8 章 | 或门 | ✅ | ✅ 完整工程 |
| `p1-basics/gate/not_gate` | 第 8 章 | 非门 | ✅ | ✅ 完整工程 |
| `p1-basics/gate/all_gate` | 第 8 章 | 与 / 或 / 非三个门合并为一个工程上板 | ✅ | ✅ 完整工程 |
| `p1-basics/mux2_1` | 第 9 章 | 2 选 1 多路选择器 | ✅ | ✅ 完整工程 |
| `p1-basics/decoder3_8` | 第 10 章 | 3-8 译码器 | ✅ | 🧪 仅仿真 |
| `p1-basics/shift_reg` | 第 12 章 | 移位寄存器 | ✅ | 📄 工程待补 |
| `p1-basics/counter` | 第 13 章 | 参数化计数器 | ✅ | 🧪 仅仿真 |
| `p1-basics/counter_1s` | 第 13 章 | 1 s 定时计数器 | ✅ | 🧪 仅仿真 |
| `p1-basics/edge_test` | 第 14 章 | 边沿检测（上升沿 / 下降沿） | ✅ | 📄 工程待补 |
| `p1-basics/divider_4` | 第 15 章 | 偶数分频（4 分频） | ✅ | 🧪 仅仿真 |
| `p1-basics/divider_7` | 第 15 章 | 奇数分频（7 分频） | ✅ | 🧪 仅仿真 |

> 第 7 章数电基础为速通内容；第 11 章锁存器为对照练习（故意造出 latch 再修掉），未单独保留工程。

### P2 · 板级外设（第 16–20 章）

| 练习 | 指南 | 内容 | 自检 TB | 状态 |
|---|---|---|---|---|
| `p2-peripherals/flow_led` | 第 16 章 | 流水灯（参数化 + 可调速） | ✅ | ✅ 完整工程 |
| `p2-peripherals/flow_led_250ms` | 第 16 章 | 流水灯（250 ms 步进调速） | — | ✅ 完整工程 |
| `p2-peripherals/key_led` | 第 17 章 | 按键控制 LED（复用边沿检测） | ✅ | ✅ 完整工程 |
| `p2-peripherals/beep` | 第 18 章 | 独立消抖模块 + 按键控制蜂鸣器 | ✅ | ✅ 完整工程 |
| `p2-peripherals/two_key_beep` | 第 18 章 | 双路按键消抖 + 蜂鸣器 | — | ✅ 完整工程 |
| `p2-peripherals/touch_led` | 第 19 章 | 触摸按键控制 LED（选做） | ✅ | ✅ 完整工程 |
| `p2-peripherals/breath_led` | 第 20 章 | 呼吸灯（PWM）+ PDS 在线逻辑分析仪 | ✅ | ✅ 完整工程 |

### P3 · IP 核（第 21–24 章）

| 练习 | 指南 | 内容 | 自检 TB | 状态 |
|---|---|---|---|---|
| `p3-ip/ip_pll` | 第 21 章 | PLL IP：多路时钟输出 + 片上逻辑分析仪测频比 | ✅ | ✅ 完整工程 |
| `p3-ip/ip_1port_ram` | 第 22 章 | 单端口 RAM IP：读写与读延时核对 | ✅ | ✅ 完整工程 |
| `p3-ip/ip_2port_ram` | 第 23 章 | 双端口 RAM IP：跨端口读写 | ✅ | 📄 工程待补 |
| `p3-ip/ip_fifo` | 第 24 章 | FIFO IP：空满判断 + 逻辑分析仪抓 `full` / `empty` | ✅ | ✅ 完整工程 |

## 如何构建 / 复现

1. **打开工程**：PDS → `File > Open Project` → 选择 `<阶段>/<练习>/prj/<练习名>.pds`
2. **引脚与时钟约束**：见各工程的 `prj/*.fdc`（器件 PGL50G-6MBG324，系统时钟 50 MHz）
3. **IP 核**（P3）：`prj/ipcore/` 保留 IP 配置 `.idf` 与生成文件；换机器或换 PDS 版本时，可在 PDS IP Compiler 中按 `.idf` 重新生成
4. **仿真**：用 ModelSim 编译 `sim/tb/tb_*.v` 与对应 `rtl/*.v`；带 IP 的工程需先用 PDS 编译器件仿真库（Tools → Compile Simulation Libraries）
5. 仓库不含位流与中间文件，构建时会自动重新生成

## 声明

- 本仓库是**个人学习练习记录**，参考《【正点原子】ATK-L50 开发板之 FPGA 开发指南》V1.0 完成，**不是官方例程**；仓库不包含指南原文、图片、课件或随板资料。
- 代码以自己动手实现为主，用于记录学习过程；**未添加开源许可证**（保留权利），欢迎参考，请勿整段转载。

## 后续计划

- **P4 协议与接口**：UART（进行中）→ SPI Flash → I2C EEPROM，完成后归入 `p4-protocols/`
- **P4.5 面试硬门槛**：CDC（同步器 / 握手）、手写同步与异步 FIFO、STA 与时序约束、AXI4-Lite
- **综合小项目**：方向待定（信号处理 / 高速接口）
- 维护方式：每个练习完成后单独提交，README 索引表同步更新

---

*最后更新：2026-10-27*
